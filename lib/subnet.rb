
require "netaddr"
require "guest"


class Subnet

  attr_accessor :name

  def initialize
    @name = ""
    @guests = []
  end

  def ip4
    @pi4
  end

  def ip4=(cidr)
    puts "  network #{cidr}"
    @network = NetAddr::CIDR.create(cidr)   # define subnet
    @pool = @network.enumerate              # create pool of addresses
    @pool.shift 10                          # first 10 IPs are reserved (Cisco LLD)
  end

  def guest
    g = Guest.new
    yield g
    @guests << g
  end

  def to_h
    { :name   => @name,
      :guests => @guests.map {|g| g.to_h }
    }
  end

end
