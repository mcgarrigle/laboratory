
module Adapter

  def bridged
    return {:bridged => nil}
  end

  def nat
    return {:nat => nil}
  end

  def intnet(name = :intnet)
    return {:intnet => {:intnet => name.to_s}}
  end

  def natnetwork(name)
    return {:natnetwork => {"nat-network" => name.to_s}}
  end

  def hostonly(name)
    return {:hostonly => {:hostonlyadapter => _vboxnet(name.to_s)}}
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

end
