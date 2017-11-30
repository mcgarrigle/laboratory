
require "netaddr"
require "forward"

class Interface

  attr_accessor :id, :netmask4, :prefix4, :gateway4, :rules
  attr_reader   :connection, :network_name

  def initialize(id = 0)
    @id           = id
    @connection   = :nat
    @network_name = ""
    @ip4          = "0.0.0.0"
    @netmask4     = "0.0.0.0"
    @gateway4     = "0.0.0.0"
    @prefix4      = "/0"
    @rules        = []
  end

  def network(connection, name = "")
    @connection   = assert(connection, :bridged, :nat, :intnet, :natnetwork, :hostonly)
    if name.class == Fixnum
      @network_name = hostonly_interface(name)
    else
      @network_name = name.to_s
    end
  end

  def ip4=(s)
    if s.include? '/'
      cidr = NetAddr::CIDR.create(s) 
      @ip4      = cidr.ip
      @netmask4 = cidr.netmask_ext
      @prefix4  = cidr.netmask
    else
      @ip4 = s
    end
  end

  def ip4
    @ip4
  end

  # def Forward.initialize(name, protocol: :tcp, from:, to:)

  def forward(name, options = {})
    rule = Forward.new(name, options)
    @rules << rule
  end

  def nic
    return "nic#{@id}".to_sym
  end

  def nic_network
    param = case @connection
    when :intnet     then "intnet"
    when :natnetwork then "nat-network"
    when :hostonly   then "hostonlyadapter"
    else "nic"
    end
    return "#{param}#{@id}".to_s
  end 

  def hostonly_interface(n)
    if ENV["OS"] == "Darwin"
      return "vboxnet#{n}"
    else
      name = "VirtualBox Host-Only Ethernet Adapter"
      return name if n  == 0
      return "#{name} ##{n + 1}"
    end
  end

  def assert(value, *valid)
    raise ArgumentError, "#{value} should be one of #{valid.join(', ')}" unless (valid.include? value)
    value
  end

end

