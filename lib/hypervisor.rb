
require "vbox"
require "vm"

class Hypervisor

  def initialize
  end

  def list
    all     = Vbox.list(:vms)
    running = Vbox.list(:runningvms)
    vms = all.map do |id, name|
      vm = VM.new(id, name)
      vm.state = running[id] ? :running : :stopped
      vm
    end
    return vms
  end

  def create(guest)
    vbox = Vbox.new(guest.name)
    vbox.createvm(:ostype => guest.ostype)
    vbox.modifyvm(:ioapic => :on)
    vbox.modifyvm(:memory => guest.memory, :vram => guest.vram)
    vbox.modifyvm(:nic1 => :intnet)
    vbox.modifyvm(:natdnshostresolver1 => :on)
    vbox.modifyvm(:boot1 => :net)
    vbox.modifyvm(:boot2 => :dvd)
    vbox.modifyvm(:boot3 => :disk)
    vbox.storagectl(:name => "IDE", :add => :ide)
    vbox.storagectl(:name => "SATA", :add => :sata, :controller => :IntelAHCI)
    dvds,disks = guest.disks.partition {|d| d.device == :sr0 }
    dvd = dvds.first
    vbox.storageattach(:storagectl => "IDE", :port => 0, :device => 0, :type => :dvddrive, :medium => dvd.medium)
    disks.each do |disk|
      path = File.join(ENV["HOME"], "VirtualBox VMs", guest.name, "#{disk.device}.vdi")
      vbox.createhd(:filename => path, :size => disk.size)
      vbox.storageattach(:storagectl => "SATA", :port => 0, :device => 0, :type => :hdd, :medium => path)
    end
  end

  def start(guest)
    vbox = Vbox.new(guest.name)
    vbox.startvm(:type => :headless)
  end

  def stop(guest)
  end

  def destroy(guest)
  end

end
