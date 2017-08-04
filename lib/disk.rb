
class Disk

  attr_accessor :device, :port, :size, :medium

  def initialize(device = :sda, size = 32768)
    @device = device
    @size   = size
  end

end
