
require "vm"


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

  def flatten(args = {})
    args.map {|k,v| "--#{k.to_s} #{string v}"}.join(" ")
  end

  def create(args = {})
    cmd("createvm --register", args)
  end

  def method_missing(method, *args)
    hash = args.first
    cmd("#{method} \"#{@name}\"", hash)
  end

  def cmd(s, args)
    puts %Q[vboxmanage #{s} #{flatten args}]
  end

end


class Hypervisor

  def initialize
    @vbox = Vbox.new
  end

  def vblist(s)
    vms = %x[vboxmanage list #{s}]
    vms = vms.lines.map {|s| /"(.+)" (.*)/.match(s.chomp); [$2,$1] }
    Hash[vms]
  end

  def list
    all     = vblist(:vms)
    running = vblist(:runningvms)
    vms = all.map do |id, name|
      vm = VM.new(id, name)
      vm.state = running[id] ? :running : :stopped
      vm
    end
    return vms
  end

  def create(guest)
    vbox = Vbox.new(guest.name)
    vbox.create(:name => guest.name, :ostype => "RedHat_64")
    vbox.modifyvm(:ioapic => :on)
    vbox.modifyvm(:memory => 1024, :vram =>128)
    vbox.modifyvm(:nic1 => :intnet)
    vbox.modifyvm(:natdnshostresolver1 => :on)
    vbox.modifyvm(:boot1 => :net)
    vbox.modifyvm(:boot2 => :dvd)
    vbox.modifyvm(:boot3 => :disk)
    vbox.storagectl(:name => "SATA Controller", :add => :sata, :controller => :IntelAHCI)
  end

  def start(guest)
    system %Q[vboxmanage startvm "#{guest.id}" --type headless]
  end

  def stop(guest)
  end

  def destroy(guest)
  end

end
