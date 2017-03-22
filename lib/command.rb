
class Command 

  def initialize(subnet)
    @subnet     = subnet
    @hypervisor = Hypervisor.new
  end

  def _list_help_text
    "list: lists guests"
  end

  def _list
    list = @hypervisor.list
    list.each do |guest|
      p guest
    end
  end

  def _up_help_text
    "up: starts all guests"
  end

  def _up
    targets = @subnet.guests.select {|g| g.enabled }
    targets.each do |guest|
      up(guest)
    end
  end

  def _down_help_text
    "down: stop all guests"
  end

  def _down
    @subnet.guests.each do |guest|
      down(guest)
    end
  end

  def _help
    methods = self.class.instance_methods.select {|m| m.to_s.end_with? "_help_text" }
    text = methods.map {|method| self.send method }.join("\n")
    puts "\n#{text}"
  end

  def up(guest)
    @hypervisor.create(guest)
    @hypervisor.start(guest)
  end

  def down(guest)
    @hypervisor.stop(guest)
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
