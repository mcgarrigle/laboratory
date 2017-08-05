
require "network"
require "guest"


class Laboratory

  attr_accessor :name, :domain

  def initialize(name = "")
    @name     = name
    @networks = {}
    @guests   = {}
    @domain   = "foo.local"
  end

  def network(name, options = {})
    name = name.to_s
    @networks[name] = Network.new(name, options)
  end

  def guest(name = nil)
    g = Guest.new(name)
    yield g
    @guests[g.name] = g
  end

  def guests
    @guests.values
  end

  def find(name)
    @guests[name]
  end

end

