

require "interface"
require "disk"


class Guest

  def initialize
    @name = [*('a'..'z')].sample(8).join
    @memory     = 1024
    @interfaces = []
    @disks      = []
  end

  def name s
    @name = s
    puts "guest #{s}"
  end

  def memory m
    @memory = m
  end

  def interface(ip4:nil, gateway4: nil)
    i = Interface.new(ip4, gateway4)
    @interfaces << i
  end

  def disk(device:nil, size:1000)
    d = Disk.new(device, size)
    @disks << d
  end 

  def to_h
    { :name       => @name,
      :interfaces => @interfaces.map {|i| i.to_h },
      :disks      => @disks.map {|d| d.to_h }
    }
  end

end

