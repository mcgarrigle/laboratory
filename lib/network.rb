
require 'netaddr'

class NetworkClashError < RuntimeError
end

class Network

  attr_accessor :name, :connection, :cidr, :ip4, :netmask4, :prefix4

  def initialize(name, options = {})
    @name = name.to_s 
    @connection, address = options.first
    assert(@connection, :nat, :natnetwork, :intnet, :hostonly)
    @cidr = NetAddr::CIDR.create(address)
    @ip4      = @cidr.base
    @netmask4 = @cidr.netmask_ext
    @prefix4  = @cidr.netmask
  end

  # determine if networks are compatible
  # the are if:
  # * they are connected in the same way
  # * they have the same cidr

  def ===(b)
    if self.cidr != b.cidr
      return false
    end
    raise NetworkClashError if self.connection != b.connection
    true
  end

  def assert(value, *valid)
    raise "#{value} is an incorrect option" unless (valid.include? value)
  end

end
