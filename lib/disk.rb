
class Disk

  def initialize(device, size)
    @device = device
    @size   = size
  end

  def to_h
    { :device => @device, :size => @size }
  end

end
