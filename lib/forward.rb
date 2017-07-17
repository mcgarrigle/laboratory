
require 'ipaddr'


class Forward

  attr_accessor :name, :protocol, :from_ip, :from_port, :to_ip, :to_port

  def initialize(name, options = {})
    @name     = name
    @protocol = options[:protocol] || :tcp
    rule = find_rule(options)
    (@from_ip, @from_port) = endpoint(rule)
    (@to_ip, @to_port) = endpoint(options[rule])
  end

  def find_rule(options)
    keys = options.keys.select {|k| k.class == String }
    raise "only one port forwarding rule allowed" unless keys.size == 1
    return keys.first
  end

  def ipaddr(s)
    return "" if s.empty?
    ip = IPAddr.new(s)
    return s
  end

  def endpoint(s)
    ip, port = s.split(":",2)
    ip = ipaddr(ip)
    return [ip, port]
  end

  def to_s
    "#{@name},#{@protocol},#{@from_ip},#{@from_port},#{@to_ip},#{@to_port}"
  end

end

