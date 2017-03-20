
class Command 

  def initialize
    @hypervisor = Hypervisor.new
  end

  def _list_help
    "lists guests"
  end

  def _list
    list = @hypervisor.list
    list.each do |guest|
      p guest
    end
  end

  def run(*args)
    method = "_#{args.shift}".to_sym
    self.send method, *args
  end

end
