
class Vbox

  def initialize(name = nil)
    @name = name
  end

  def self.list(type = :vms)
    vms = %x[vboxmanage list #{type}]
    vms = vms.lines.map {|s| /"(.+)" (.*)/.match(s.chomp); [$2,$1] }
    Hash[vms]
  end

  def createvm(args = {})
    command("createvm --register", args)
  end

  def method_missing(method, *args)
    command("#{method} \"#{@name}\"", args.first)
  end

  def command(s, args)
    system %Q[vboxmanage #{s} #{flatten args}]
  end

  def flatten(args = {})
    args.map {|k,v| "--#{k.to_s} #{string v}"}.join(" ")
  end

  def string(s)
    case s
    when String then "\"#{s}\""
    else s.to_s
    end
  end

end
