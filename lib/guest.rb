
class Guest

  def initialize
    @name = [*('a'..'z')].sample(8).join
    @interfaces = []
  end

  def name s
    @name = s
    puts "guest #{s}"
  end

  def method_missing(name, *args)
    /^([a-z]+)/.match(name.to_s)
    self.send($1, *args)
  end

  def interface(*args)
    puts "  interface #{args}"
    @interfaces << args
  end

  def definition
    { :name       => @name,
      :interfaces => @interfaces
    }
  end

end

