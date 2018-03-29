
require "network"
require "guest"
require "plugins"


class Laboratory

  attr_accessor :name, :domain
  attr_reader   :networks

  def initialize(name = "")
    @name = name
    @domain = "foo.local"
    @nameservers = []
    @networks = {}
    @guests = {}
    @plugins = {}
  end

  def nameservers(servers = nil)
    case servers
    when NilClass 
      return @nameservers
    when Array 
      @nameservers = servers
    else
      @nameservers = [servers]
    end
  end

  def plugin(name, options = {})
    klass = Plugins.load(name)
    @plugins[name.to_s] = klass.new(self, options)
  rescue => e
    puts "#{name} plugin did not initialize: #{e.message}"
  end

  def plugins
    @plugins.values
  end

  def network(name, options = {})
    name = name.to_s
    @networks[name] = Network.new(name, options)
  end

  def guest(name = nil)
    g = Guest.new(name)
    yield g if block_given?
    g.fqdn = "#{name}.#{domain}"
    @guests[g.name] = g
  end

  def guests
    @guests.values
  end

  def [](name)
    @guests[name]
  end

end

