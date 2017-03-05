
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

  def subnet(&block) 
    @subnet = Subnet.new
    @subnet.instance_eval &block
  end

  def define(s)
    eval(s)
    p @subnet.to_h
  end

end

