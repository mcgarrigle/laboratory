

require "netaddr"


class Subnet

  def name s
     @name = s
     puts "name #{s}"
  end

  def ip4 cidr
    puts "network #{cidr}"
    @network = NetAddr::CIDR.create(cidr)   # define subnet
    @pool = @network.enumerate              # create pool of addresses
    @pool.shift 10                          # first 10 IPs are reserved (Cisco LLD)
  end

  def guest n
     puts "guest #{n}"
  end

end

