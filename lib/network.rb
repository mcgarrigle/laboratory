
require 'netaddr'

class Network

  attr_accessor :name, :connection, :ip4, :netmask4, :prefix4

  def initialize(name, options = {})
    @name = name.to_s 
    @connection, address = options.first
    cidr = NetAddr::CIDR.create(address)
    @ip4      = cidr.ip
    @netmask4 = cidr.netmask_ext
    @prefix4  = cidr.netmask
  end

end
