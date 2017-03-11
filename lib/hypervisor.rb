
require "vbox"
require "vm"

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
    vbox.create(:name => guest.name, :ostype => guest.ostype)
    vbox.modifyvm(:ioapic => :on)
    vbox.modifyvm(:memory => guest.memory, :vram => guest.vram)
    vbox.modifyvm(:nic1 => :intnet)
    vbox.modifyvm(:natdnshostresolver1 => :on)
    vbox.modifyvm(:boot1 => :net)
    vbox.modifyvm(:boot2 => :dvd)
    vbox.modifyvm(:boot3 => :disk)
    vbox.storagectl(:name => "IDE Controller", :add => :ide)
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
