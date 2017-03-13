
require "netaddr"


class Interface

  attr_accessor :netmask4, :prefix4, :gateway4

  def initialize
    @ip4      = "0.0.0.0"
    @netmask4 = "0.0.0.0"
    @gateway4 = "0.0.0.0"
    @prefix4  = "/0"
  end

  def ip4=(s)
    if s.include? '/'
      network = NetAddr::CIDR.create(s) 
      @ip4      = network.ip
      @netmask4 = network.netmask_ext
      @prefix4  = network.netmask
    else
      @ip4 = s
    end
  end

  def ip4
    @ip4
  end

end
