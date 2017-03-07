
class Interface

  attr_accessor :ip4, :gateway4

  def inspect
    "ip4 = #{@ip4} gw4 = #{@gateway4}"
  end

  def to_h
    { :ip4 => @ip4, :gateway4 => @gateway4 }
  end

end
