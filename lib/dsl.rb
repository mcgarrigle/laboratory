
require "hypervisor"
require "laboratory"


module Dsl

  def domain d
    @domain = d
  end

  def laboratory(name = "")
    @laboratory = Laboratory.new(name)
    yield @laboratory
  end

end

include Dsl
