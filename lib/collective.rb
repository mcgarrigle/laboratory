
require "subnet"


class Collective

  def domain d
    @domain = d
    puts "domain #{d}"
  end

  def subnet(&block) 
    s = Subnet.new
    s.instance_eval &block
  end

  def define(s)
    eval(s)
  end

end

