describe("processes a list of ") do
  it("fail") do
    IO.popen("bin/readmefy_a_list", "r+") do |io|
      io << "{\"content\" : \"hello\"}"
      io.flush()
      io.close_write()
      io.read.should == "hello"
    end
  end
end
