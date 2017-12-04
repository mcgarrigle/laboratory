
class Adapter

  def self.bridged
    return {:bridged => nil}
  end

  def self.nat
    return {:nat => nil}
  end

  def self.intnet(name = :intnet)
    return {:intnet => {:intnet => name.to_s}}
  end

  def self.natnetwork(name)
    return {:natnetwork => {"nat-network" => name.to_s}}
  end

  def self.hostonly(name)
    return {:hostonly => {:hostonlyadapter => _vboxnet(name.to_s)}}
  end

  def self._vboxnet(name)
    return name unless Gem.win_platform?
    n = name[/\d+/].to_i
    if n == 0
      return "VirtualBox Host-Only Ethernet Adapter"
    else
      return "VirtualBox Host-Only Ethernet Adapter ##{n + 1}"
    end
  end

end
