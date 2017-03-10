
require "vm"

class Hypervisor

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
  end

  def start(guest)
    system %Q[vboxmanage startvm "#{guest.id}" --type headless]
  end

  def stop(guest)
  end

  def destroy(guest)
  end

end
