require('amqp')

describe("bin/rabbitmq_to_repo_process") do
  before do
    #flush the test queue and add a gem to it.
     @event_machine_thread = Thread.new {EventMachine.run}
     while !EM.reactor_running?; end
     @connection = AMQP.connect(:host => 'localhost')
     @channel = AMQP::Channel.new(@connection)
     @queue = @channel.queue("test")
     @queue.publish("hello")
     @queue.publish("goodbye")
  end

  it("should pull a list of tasks through an arbitrary process") do
    io = IO.popen("bin/rabbitmq_to_repo_process test spec/fixtures/test_process.rb serializers/noop.rb", "r") do |io|
      begin

      x = io.read(13)
      Process.kill("TERM", io.pid)
      x += io.readline()
      x.should == "START;HELLO,GOODBYE;STOP\n"
      ensure
        Process.kill("TERM", io.pid)
      end
    end

  end

  after do
    @event_machine_thread.exit
  end
end
