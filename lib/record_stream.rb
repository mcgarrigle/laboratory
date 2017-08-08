
class RecordStream

  def initialize(stream)
    @stream = stream
  end

  def records
    chunks = @stream.chunk { |line| line != "" || nil }.map { |_, lines| lines }
    chunks.map{|chunk| grok(chunk) }
  end

  def grok(lines)
    array = lines.map {|s| /^([A-Za-z0-9 ]+):\s+(.*)/ =~ s; [$1, $2] }.reject {|a, _| a == nil }
    Hash[array]
  end

end

