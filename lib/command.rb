
class Command 

  def initialize(subnet)
    @subnet     = subnet
    @hypervisor = Hypervisor.new
  end

  def _list_help_text
    "list: lists guests"
  end

  def _list
    list = Hypervisor.list
    list.each do |guest|
      puts guest
    end
  end

  def _up_help_text
    "up: starts all guests"
  end

  def all_guests
    vms = Hypervisor.list.map {|g| [g.name, g.state] }
    Hash[vms]
  end

  def status
    vms = all_guests
    @subnet.guests.each {|g| g.status = vms[g.name] }
    @subnet.guests
  end

  def _up
    targets = status.select {|g| g.enabled }
    targets.select {|g| g.status.nil? }.each do |guest|
      puts "create #{guest.name}"
      @hypervisor.create(guest) 
    end
    targets.reject {|g| g.status == :running }.each do |guest|
      puts "starting #{guest.name}"
      @hypervisor.start(guest)
    end
  end

  def _down_help_text
    "down: stop all guests"
  end

  def _down
    @subnet.guests.each do |guest|
      @hypervisor.stop(guest)
    end
  end

  def _help
    methods = self.class.instance_methods.select {|m| m.to_s.end_with? "_help_text" }
    text = methods.map {|method| self.send method }.join("\n")
    puts "\n#{text}"
  end

  def run(*args)
    command = args.shift
    method  = "_#{command}".to_sym
    unless self.respond_to? method
      puts "command '#{command}' not known"
      _help
      exit
    end
    self.send method, *args
  end

end
