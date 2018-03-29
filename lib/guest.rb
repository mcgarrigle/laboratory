
require "interface"
require "disk"

class Guest

  attr_accessor :name, :fqdn, :enabled, :cores, :memory, :vram, :ostype
  attr_accessor :interfaces, :disks

  def initialize(name = "foo")
    @name       = name.to_s
    @fqdn       = @name
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

  def status=(s)
    @status = s
  end

  # :defined  => in lab but no VM created
  # :stopped  => in hypervisor but not running
  # :running  => running in hypervisor
  # :disabled => defined in lab but will not be started
  #              but can be stopped and destroyed

  def status
    return :disabled unless @enabled
    case @status
    when nil then :defined
    else @status
    end
  end

  def to_s
    "%8s %s" % [status, @name]
  end

  def disabled
    @enabled = false
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
    i = Interface.new(@fqdn, n)
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
