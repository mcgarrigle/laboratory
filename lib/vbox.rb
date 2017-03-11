
class Vbox

  def initialize(name = nil)
    @name = name
  end

  def string(s)
    case s
    when String then "\"#{s}\""
    else s.to_s
    end
  end

  def create(args = {})
    cmd("createvm --register", args)
  end

  def method_missing(method, *args)
    cmd("#{method} \"#{@name}\"", args.first)
  end

  def cmd(s, args)
    puts %Q[vboxmanage #{s} #{flatten args}]
  end

  def flatten(args = {})
    args.map {|k,v| "--#{k.to_s} #{string v}"}.join(" ")
  end

end
