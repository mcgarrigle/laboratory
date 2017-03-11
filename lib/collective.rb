
require "hypervisor"
require "subnet"


module Collective

  def domain d
    @domain = d
  end

  def subnet
    @subnet = Subnet.new
    yield @subnet
  end

end

include Collective
