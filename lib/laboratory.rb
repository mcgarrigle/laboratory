
require "netaddr"
require "guest"


class Laboratory

  attr_accessor :name, :guests

  def initialize(name = "")
    @name = name
    @guests = []
  end

  def ip4
    @pi4
  end

  def ip4=(cidr)
    @network = NetAddr::CIDR.create(cidr)   # define subnet
    @pool = @network.enumerate              # create pool of addresses
    @pool.shift 10                          # first 10 IPs are reserved 
  end

  def guest(name = nil)
    g = Guest.new(name)
    yield g
    @guests << g
  end

  def find(name)
    @guests.select {|g| g.name == name }.first
  end

end
