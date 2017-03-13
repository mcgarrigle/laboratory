
require "interface"
require "disk"

class Guest

  attr_accessor :name, :memory, :vram, :ostype
  attr_accessor :interfaces, :disks

  def initialize
    @name       = [*('a'..'z')].sample(8).join
    @memory     = 1024
    @vram       = 128
    @ostype     = "RedHat_64"
    @interfaces = []
    @disks      = []
    @block      = :sda
  end

  def interface
    i = Interface.new
    yield i
    @interfaces << i
  end

  def disk
    d = Disk.new
    d.device = @block
    @block = @block.succ
    yield d
    @disks << d
  end

  def dvd
    d = Disk.new(:sr0)
    d.medium = 'emptydrive'
    yield d
    @disks << d
  end

end
