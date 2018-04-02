
require "vbox"
require "vm"

class Virtualbox

  def initialize
    @machine_folder = Vbox.machine_folder
  end

  def self.list
    all     = Vbox.vms(:vms)
    running = Vbox.vms(:runningvms)
    vms = all.map do |id, name|
      vm = VM.new(id, name)
      vm.state = running[id] ? :running : :stopped
      vm
    end
    return vms
  end

  def self.status
    Vbox.networks
    vms = list.map {|g| [g.name, g.state] }
    Hash[vms]
  end

  def create(guest)
    @vbox = Vbox.new(guest.name)
    @vbox.createvm(:ostype => guest.ostype)
    @vbox.modifyvm(:cpus => guest.cores)
    @vbox.modifyvm(:memory => guest.memory, :vram => guest.vram)
    @vbox.modifyvm(:ioapic => :on)
    @vbox.modifyvm(:natdnshostresolver1 => :on)

    guest.boot.each_with_index do |device, i|
      boot = "boot#{i + 1}"
      @vbox.modifyvm(boot => device)
    end

    guest.interfaces.each do |interface|
      create_interface(interface)
    end

    @vbox.storagectl(:name => "SATA", :add => :sata, :controller => :IntelAHCI)

    dvds, disks = guest.disks.partition {|d| d.device == :sr0 }
    dvd = dvds.first  # only one dvd

    if dvd
      @vbox.storagectl(:name => "IDE", :add => :ide)
      @vbox.storageattach(:storagectl => "IDE", :port => 0, :device => 0, :type => :dvddrive, :medium => dvd.medium)
    end

    disks.each_with_index do |disk, port|
      disk.port = port
      create_disk(disk)
    end
  rescue
    raise
  end

  def create_interface(interface)
    macaddress = "macaddress#{interface.id}"
    @vbox.modifyvm(interface.nic => interface.connection, macaddress => interface.mac)
    case interface.connection
    when :intnet, :natnetwork, :hostonly then 
      @vbox.modifyvm(interface.adapter => interface.name)
    end
    port = "natpf#{interface.id}".to_sym
    interface.rules.each do |rule|
      @vbox.modifyvm(port => rule.to_s)
    end
  end

  def create_disk(disk)
    path = File.join(@machine_folder, @vbox.name, "#{disk.device}.vdi")
    @vbox.createhd(:filename => path, :size => disk.size)
    @vbox.storageattach(:storagectl => "SATA", :port => disk.port, :device => 0, :type => :hdd, :medium => path)
  end

  def start(guest, type = :headless)
    vbox = Vbox.new(guest.name)
    vbox.startvm(type)
  end

  def stop(guest, type = :acpipowerbutton)
    vbox = Vbox.new(guest.name)
    vbox.stopvm(type)
  end

  def destroy(guest)
    vbox = Vbox.new(guest.name)
    vbox.unregistervm
  end

end

