
require "interface"
require "disk"

class Guest

  attr_accessor :name, :enabled, :cores, :memory, :vram, :ostype
  attr_accessor :interfaces, :disks, :status

  def initialize(name = "foo")
    @name       = name.to_s
    @enabled    = true
    @cores      = 1
    @memory     = 1024
    @vram       = 128
    @usb        = nil
    @ostype     = "RedHat_64"
    @boot       = [:net, :dvd, :disk]
    @interfaces = []
    @disks      = []
    @block      = :sda
  end

  def self.newname
    [*('a'..'z')].sample(8).join
  end

  def to_s
    status = @status || "defined"
    "%7s %s" % [status, @name]
  end

  def boot=(order)
    raise ArgumentError, "not an array on boot" unless (Array === order)
    wrong = order - [:net, :dvd, :disk]
    raise ArgumentError, "did not expect on boot command (#{wrong})" if wrong.size > 0 
    @boot = order
  end

  def boot
    @boot
  end

  def interface
    n = @interfaces.size + 1
    i = Interface.new(@name, n)
    yield i
    @interfaces << i
  end

  def disk
    d = Disk.new(@block)
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

  def usb=(bus)
    @usb = bus
  end

  def usb
    @usb
  end

end
