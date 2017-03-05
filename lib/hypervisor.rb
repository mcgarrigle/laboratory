
class Hypervisor

  def list
    vms = %x[vboxmanage list vms]
    vms.lines.map {|s| /"(.+)" /.match(s); $1 }
  end

  def create(guest)
  end

  def start(guest)
  end

  def stop(guest)
  end

  def destroy(guest)
  end

end
