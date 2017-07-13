
class Forward

  attr_accessor :protocol, :from_ip, :from_port, :to_ip, :to_port

  def initialize(name, options)
  end

  def to_s
    "ssh,tcp,127.0.0.1,2022,10.0.30.100,22"
  end

end

