describe("unpack_jason_array") do
  it("should strip a JSON array down by one layer") do
    IO.popen("bin/unpack_json_array", "r+") do |io|
      io << "[\"hello\",{\"object\" : 2 },[\"array\"]"
      io.flush()
      io.close_write()
      io.read.should == "\"hello\"{\"object\":2}[\"array\"]"
    end
  end
end