
require "interface"
require "disk"


class Guest

  attr_accessor :name, :memory

  def initialize
    @name       = [*('a'..'z')].sample(8).join
    @memory     = 1024
    @interfaces = []
    @disks      = []
  end

  def interface
    i = Interface.new
    #i.instance_eval &block
    yield i
    @interfaces << i
  end

  def disk
    d = Disk.new
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
