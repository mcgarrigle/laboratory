
require "virtualbox"
require "laboratory"


module Dsl

  def laboratory(name = "")
    @laboratory = Laboratory.new(name)
    yield @laboratory
    vms = Virtualbox.status
    @laboratory.guests.each {|g| g.status = vms[g.name] } 
  end

end

include Dsl
