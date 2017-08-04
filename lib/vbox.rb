
require 'nokogiri'

class Vbox

  def initialize(name = nil)
    @name = name
  end

  def name
    @name
  end

  def self.config_file
    home = ENV["HOME"]
    if ENV["OS"] == "Darwin"
      return File.join(home, "Library", "VirtualBox", "Virtualbox.xml")
    else
      return File.join(home, ".VirtualBox", "Virtualbox.xml")
    end
  end

  def self.machine_folder
    doc = Nokogiri::XML(File.read(config_file))
    return doc.at_xpath("//xmlns:SystemProperties/@defaultMachineFolder").to_s
  end

  def self.list(type = :vms)
    vms = %x[vboxmanage list #{type}]
    vms = vms.lines.map {|s| /"(.+)" (.*)/.match(s.chomp); [$2,$1] }
    Hash[vms]
  end

  def createvm(args = {})
    command("createvm", "--register", "--name", @name, *argv(args))
  end

  def createhd(args = {})
    command("createhd", *argv(args))
  end

  def modifyvm(args = {})
    command("modifyvm", @name, *argv(args))
  end

  def storagectl(args = {})
    command("storagectl", @name, *argv(args))
  end

  def storageattach(args = {})
    command("storageattach", @name, *argv(args))
  end

  def startvm(type = :headless)
    command("startvm", @name, '--type', type.to_s)
  end

  def stopvm(type = :acpipowerbutton)
    ok = [:poweroff, :acpipowerbutton]
    raise "shutdown type '#{type}' not known" unless ok.include? type
    command("controlvm", @name, type.to_s)
  end

  def unregistervm
    command("unregistervm", @name, "--delete")
  end

  def command(*args)
    # puts "vboxmanage #{args.join(' ')}"; return
    ok = system("vboxmanage", *args)
    raise "error calling: #{args}" unless ok
  end

  def argv(args = {})
    args.map {|k,v| ["--#{k.to_s}", v.to_s] }.flatten
  end

end
