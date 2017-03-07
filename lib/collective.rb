
require "hypervisor"
require "subnet"


class Collective

  def initialize
    @hypervisor = Hypervisor.new
  end

  def domain d
    @domain = d
    puts "domain #{d}"
  end

  def subnet
    @subnet = Subnet.new
    yield @subnet
  end

  def define(s)
    eval(s)
    p @subnet.to_h
  end

end
