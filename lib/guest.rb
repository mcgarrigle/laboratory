
require "interface"
require "dvd"
require "disk"

class Guest

  attr_accessor :name, :memory, :vram, :ostype

  def initialize
    @name       = [*('a'..'z')].sample(8).join
    @memory     = 1024
    @vram       = 128
    @interfaces = []
    @disks      = []
    @ostype     = "RedHat_64"
  end

  def interface
    i = Interface.new
    yield i
    @interfaces << i
  end

  def disk
    d = Disk.new
    yield d
    @disks << d
  end

  def dvd
    d = Disk.new(:sr0)
    d.media = ''
    yield d
    @disks << d
  end

  def to_h
    { :name       => @name,
      :interfaces => @interfaces.map {|i| i.to_h },
      :disks      => @disks.map {|d| d.to_h }
    }
  end

end
