class ArcFile

  attr_accessor :version, :source, :stream
  def initialize(stream)
    @stream = stream
    @filedesc, reserved, content_type, date, size = stream.readline.split(" ")
    marker = stream.pos
    @version, reserved, @source = stream.readline.split(" ")
    @version_description = stream.readline()
    if((test = stream.read(1)) != "\n")
      raise Exception.new("header always ends with newline got \"#{test}\"")
    end
    
    if( stream.pos-marker != size.to_i )
      raise Exception.new("mistaken size: expected #{size} got #{stream.pos-marker+1}")
    end
  end

  def next_record()
    @last_record.seek_to_end if @last_record
    return nil if (@last_record && @last_record.eof)
    @last_record = ArcFileRecordv1.new( @stream )
    return @last_record
  end

  def self.open(filename)
    return ArcFile.new( File.open(filename) )
  end
end

class ArcFileDataStream
  def initialize(stream, offset, length)
    @archive_seek = offset
    @stream = stream
    @total_length = length
    @seek_offset = 0
  end

  def read(length)
    @stream.seek(@archive_seek + @seek_offset) if @stream.pos != @archive_seek + @seek_offset
    left_to_read = @archive_seek + @total_length - @stream.pos
    return nil if (left_to_read <= 0)
    length = left_to_read if length > left_to_read
    @seek_offset += length
    print "[#{length}, #{left_to_read}]"
    return @stream.read(length)
  end
end

class ArcFileRecordv1
  attr_accessor :url, :ip_address, :archive_date, :content_type, :length, :eof
  def initialize(stream)
    @eof = false
    @offset = stream.pos
    @url, @ip_address, @archive_date, @content_type, @length = stream.readline().split(" ")
    @length = @length.to_i
    @archive_date = DateTime.strptime(@archive_date, "%Y%m%d%H%M%S")
    @archive_seek = stream.pos
    @stream = stream
    #stream.read(@archive_length)
  end

  def data()
    return ArcFileDataStream.new(@stream, @archive_seek, @length)
  end

  def seek_to_end()
    @stream.seek(@archive_seek + @length + 2)
    begin
      blankchar = @stream.read(1)
      while( blankchar && blankchar.strip.empty? )
        blankchar = @stream.read(1)
      end 
      @eof = true if blankchar.nil?
    rescue EOFError
      @eof = true
    end
    @stream.seek(-1, IO::SEEK_CUR)
  end

end


