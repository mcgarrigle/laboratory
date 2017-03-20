
class Command 

  def initialize
    @hypervisor = Hypervisor.new
  end

  def _list
    list = @hypervisor.list
p :list
  end

  def run(*args)
    method = "_#{args.shift}".to_sym
    self.send method, *args
  end

end
