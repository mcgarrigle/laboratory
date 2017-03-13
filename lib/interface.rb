
require "netaddr"


class Interface

  attr_accessor :network, :netmask4, :prefix4, :gateway4

  def initialize
    @network  = :nat
    @ip4      = "0.0.0.0"
    @netmask4 = "0.0.0.0"
    @gateway4 = "0.0.0.0"
    @prefix4  = "/0"
  end

  def ip4=(s)
    if s.include? '/'
      cidr = NetAddr::CIDR.create(s) 
      @ip4      = cidr.ip
      @netmask4 = cidr.netmask_ext
      @prefix4  = cidr.netmask
    else
      @ip4 = s
    end
  end

  def ip4
    @ip4
  end

end
