class Subnet

  def name n
     puts "name #{n}"
  end

  def ip4 n
     puts "network #{n}"
  end

  def guest n
     puts "guest #{n}"
  end

end

def domain d
  puts "domain #{d}"
end

def subnet(&block) 
  s = Subnet.new
  s.instance_eval &block
end
