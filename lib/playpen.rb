
require "hypervisor"
require "subnet"


module Playpen

  def domain d
    @domain = d
  end

  def subnet
    @subnet = Subnet.new
    yield @subnet
  end

end

include Playpen
