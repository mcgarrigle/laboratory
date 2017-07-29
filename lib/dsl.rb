
require "hypervisor"
require "laboratory"


module Dsl

  def laboratory(name = "")
    @laboratory = Laboratory.new(name)
    yield @laboratory
  end

end

include Dsl
