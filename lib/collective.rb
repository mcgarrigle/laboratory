
require "subnet"


class Collective

  def initialize
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
  end

end

