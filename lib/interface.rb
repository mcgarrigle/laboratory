
require "digest"
require "netaddr"
require "forward"

class Interface

  attr_accessor :id, :netmask4, :prefix4, :gateway4, :rules, :mac
  attr_reader   :connection, :name

  def initialize(fqdn = "", id = 0)
    @fqdn         = fqdn
    @id           = id
    @connection   = :nat
    @adapter      = ""
    @name         = ""
    @network_name = ""
    @ip4          = "0.0.0.0"
    @netmask4     = "0.0.0.0"
    @gateway4     = "0.0.0.0"
    @prefix4      = "/0"
    @rules        = []
    @config       = {}
    @mac          = Interface.generate_mac("#{fqdn}:#{id}")
  end

  def self.generate_mac(s)
    digest = Digest::MD5.hexdigest(s).upcase
    "02" + digest[0..9]
  end

  def bridged
    @connection = :bridged
  end

  def nat
    @connection = :nat
  end

  def intnet(name = :intnet)
    @connection = :intnet
    @adapter    = "intnet"
    @name       = name.to_s
  end

  def natnetwork(name)
    @connection = :natnetwork
    @adapter    = "nat-network"
    @name       = name.to_s
  end

  def hostonly(name)
    @connection = :hostonly
    @adapter    = "hostonlyadapter"
    @name       = _vboxnet(name.to_s)
  end

  def _vboxnet(name)
    return name unless Gem.win_platform?
    n = name[/\d+/].to_i
    if n == 0
      return "VirtualBox Host-Only Ethernet Adapter"
    else
      return "VirtualBox Host-Only Ethernet Adapter ##{n + 1}"
    end
  end

  def _network(connection = {})
    @connection = assert(connection.keys.first, :bridged, :nat, :intnet, :natnetwork, :hostonly)
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
    return "nic#{@id}"
  end

  def adapter
    return "#{@adapter}#{@id}"
  end 

  def assert(value, *valid)
    raise ArgumentError, "#{value} should be one of #{valid.join(', ')}" unless (valid.include? value)
    value
  end

end

