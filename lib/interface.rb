
require "netaddr"
require "forward"

class Interface

  attr_accessor :id, :network, :netmask4, :prefix4, :gateway4, :rules

  def initialize(id = 0)
    @id       = id
    @network  = :nat
    @ip4      = "0.0.0.0"
    @netmask4 = "0.0.0.0"
    @gateway4 = "0.0.0.0"
    @prefix4  = "/0"
    @rules    = []
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

  # def Forward.initialize(name, protocol: :tcp, from:, to:)

  def forward(name, options = {})
    rule = Forward.new(name, options)
    @rules << rule
  end

  #def forward
  #  @forward
  #end

  def ip4
    @ip4
  end

end
