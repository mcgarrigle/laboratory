
require 'ipaddr'


class Forward

  attr_accessor :protocol, :from_ip, :from_port, :to_ip, :to_port

  def initialize(name, protocol: :tcp, from:, to:)
    @name     = name
    @protocol = protocol
    (@from_ip, @from_port) = endpoint(from)
    (@to_ip, @to_port) = endpoint(to)
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
    # "#{@name},#{@protocol},127.0.0.1,2022,10.0.30.100,22"
    "#{@name},#{@protocol},#{@from_ip},#{@from_port},#{@to_ip},#{@to_port}"
  end

end

