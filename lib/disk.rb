
class Disk

  attr_accessor :device, :size, :media

  def initialize(device = :sda, size = 32768)
    @device = device
    @size   = size
  end

end
