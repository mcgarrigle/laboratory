
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
    command("createvm --register --name #{string @name}", args)
  end

  def createhd(args = {})
    command("createhd", args)
  end

  def modifyvm(args = {})
    command("modifyvm \"#{@name}\"", args)
  end

  def storagectl(args = {})
    command("storagectl \"#{@name}\"", args)
  end

  def storageattach(args = {})
    command("storageattach \"#{@name}\"", args)
  end

  def startvm(type = :headless)
    command("startvm \"#{@name}\"", :type => type)
  end

  def stopvm(type = :acpipowerbutton)
    ok = [:poweroff, :acpipowerbutton]
    raise "shutdown type '#{type}' not known" unless ok.include? type
    command("controlvm \"#{@name}\" #{type}")
  end

  def command(s, args = {})
    err = system("vboxmanage #{s}#{flatten args}")
    # TODO raise "error calling: #{s}" if err
  end

  def flatten(args = {})
    return "" if args.size == 0
    " " + args.map {|k,v| "--#{k.to_s} #{string v}"}.join(" ")
  end

  def string(s)
    if String === s
      %Q["#{s}"]
    else 
      s.to_s
    end
  end

end
