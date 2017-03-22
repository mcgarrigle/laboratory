
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
    vbox.modifyvm(:natdnshostresolver1 => :on)

    guest.boot.each_with_index do |device, i|
      boot = "boot#{i + 1}".to_sym
      vbox.modifyvm(boot => device)
    end

    guest.interfaces.each_with_index do |interface, i|
      nic = "nic#{i + 1}".to_sym
      vbox.modifyvm(nic => interface.network)
      if interface.port_forward
        port = "natpf#{i + 1}".to_sym
        vbox.modifyvm(port => interface.port_forward)
      end
    end

    vbox.storagectl(:name => "IDE", :add => :ide)
    vbox.storagectl(:name => "SATA", :add => :sata, :controller => :IntelAHCI)
    dvds,disks = guest.disks.partition {|d| d.device == :sr0 }
    dvd = dvds.first

    vbox.storageattach(:storagectl => "IDE", :port => 0, :device => 0, :type => :dvddrive, :medium => dvd.medium)

    disks.each_with_index do |disk, port|
      path = File.join(ENV["HOME"], "VirtualBox VMs", guest.name, "#{disk.device}.vdi")
      vbox.createhd(:filename => path, :size => disk.size)
      vbox.storageattach(:storagectl => "SATA", :port => port, :device => 0, :type => :hdd, :medium => path)
    end
  end

  def start(guest, type = :headless)
    vbox = Vbox.new(guest.name)
    vbox.startvm(type)
  end

  def stop(guest)
    vbox = Vbox.new(guest.name)
    vbox.stopvm(type)
  end

  def destroy(guest)
  end

end
