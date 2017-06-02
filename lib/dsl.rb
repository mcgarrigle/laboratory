
require "hypervisor"
require "laboratory"


module Dsl

  def domain d
    @domain = d
  end

  def laboratory
    @laboratory = Laboratory.new
    yield @laboratory
  end

end

include Dsl
