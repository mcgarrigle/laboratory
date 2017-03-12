
class Disk

  attr_accessor :device, :size, :medium

  def initialize(device = :sda, size = 32768)
    @device = device
    @size   = size
  end

end
