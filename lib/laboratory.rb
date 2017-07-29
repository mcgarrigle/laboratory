
require "network"
require "guest"


class Laboratory

  attr_accessor :name, :guests, :domain

  def initialize(name = "")
    @name     = name
    @networks = []
    @guests   = []
    @domain   = "foo.local"
  end

  def network(name, options = {})
    @networks << Network.new(name, options)
  end

  def guest(name = nil)
    g = Guest.new(name)
    yield g
    @guests << g
  end

  def find(name)
    @guests.select {|g| g.name == name }.first
  end

end

