
class Disk

  attr_accessor :device, :size

  def initialize
  end

  def to_h
    { :device => @device, :size => @size }
  end

end
