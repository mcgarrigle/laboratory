
require 'action'
require 'hypervisor'

class Command 

  def initialize(laboratory)
    @laboratory = laboratory
    @action = Action.new(@laboratory)
  end

  def these(names)
    if names.size == 0
      guests = @laboratory.guests
    else
      guests = names.map {|n| @laboratory.find(n) }.compact
    end
    guests.each {|g| yield g }
  end

  def _list_help_text
    "lists guests"
  end

  def _list
    @action.list
  end

  def _up_help_text
    "starts all guests"
  end

  def _up(*names)
    these(names) {|guest| @action.up(guest) }
  end

  def _down_help_text
    "stop all guests"
  end

  def _down(*names)
    these(names) {|guest| @action.down(guest) }
  end
 
  def _delete_help_text
    "stop and delete all guests"
  end

  def _delete(*names)
    these(names) {|guest| @action.delete(guest) }
  end

  def _help
    methods = self.class.instance_methods.select {|m| m.to_s.end_with? "_help_text" }
    puts methods.map {|method| help(method) }.join("\n")
  end

  def help(method)
    command = method.to_s.match(/_(.*?)_/)[1]
    text = self.send method
    "%-6s - %s" % [command, text]
  end

  def run(*args)
    command = args.shift
    method  = "_#{command}".to_sym
    unless self.respond_to? method
      puts "command '#{command}' not known\n\n"
      _help
      exit
    end
    self.send method, *args
  end

end
