
class Vbox

  def initialize(name = nil)
    @name = name
  end

  def create(args = {})
    command("createvm --register", args)
  end

  def method_missing(method, *args)
    command("#{method} \"#{@name}\"", args.first)
  end

  def command(s, args)
    puts %Q[vboxmanage #{s} #{flatten args}]
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
