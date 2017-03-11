
class Disk

  attr_accessor :device, :size

  def initialize(device = :sda, size = 2028)
    @device = device
    @size   = size
  end

  def to_h
    { :device => @device, :size => @size }
  end

end
