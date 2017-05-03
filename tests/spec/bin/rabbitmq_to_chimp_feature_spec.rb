require('amqp')

describe("bin/rabbitmq_to_chimp_feature") do
  before do
    #flush the test queue and add a gem to it.
     @event_machine_thread = Thread.new {EventMachine.run}
     while !EM.reactor_running?; end
     @connection = AMQP.connect(:host => 'localhost')
     @channel = AMQP::Channel.new(@connection)
     @queue = @channel.queue("test_chimp_in", :auto_delete => true)
     @queue.publish("{\"x\":1, \"y\":2}")
     @queue.publish("garbage")
     @queue.publish("{\"x\":2, \"y\":3}")
     @queue.publish("{\"x\":4, \"y\":5, \"sum\":7}")
  end

  it("should enrich records with all available chimp features") do
    chimpserver = spawn("bin/rabbitmq_to_chimp_feature spec/fixtures/test_chimp test_chimp_in test_chimp_out")
    output_pipe = IO.popen("bin/rabbitmq_to_stdout test_chimp_out")  do |io|
      begin
      standard = "{\"x\":1,\"y\":2,\"sum\":3}\ngarbage\n{\"x\":2,\"y\":3,\"sum\":5}\n{\"x\":4,\"y\":5,\"sum\":7}\n"
      io.flush()
      x = io.read(10)
      Process.kill("TERM", io.pid)
      x += io.read()
      x.should == standard
      ensure
        Process.kill("TERM", chimpserver)
        Process.kill("TERM", io.pid)
      end
    end
  end

  after do
    @event_machine_thread.exit
  end
end
