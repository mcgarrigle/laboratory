
class Interface

  def initialize(ip4, gateway4)
    @ip4      = ip4
    @gateway4 = gateway4
  end

  def to_h
    { :ip4 => @ip4, :gateway4 => @gateway4 }
  end

end
