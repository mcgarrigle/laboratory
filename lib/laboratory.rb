
require "network"
require "guest"
require "plugins"


class Laboratory

  attr_accessor :name, :domain
  attr_reader   :plugins, :networks

  def initialize(name = "")
    @name     = name
    @domain   = "foo.local"
    @networks = {}
    @guests   = {}
    @plugins  = {}
  end

  def plugin(name, options = {})
    klass = Plugins.load(name)
    @plugins[name.to_s] = klass.new(options)
  end

  def network(name, options = {})
    name = name.to_s
    @networks[name] = Network.new(name, options)
  end

  def guest(name = nil)
    g = Guest.new(name)
    yield g if block_given?
    @guests[g.name] = g
  end

  def guests
    @guests.values
  end

  def find(name)
    @guests[name]
  end

end

