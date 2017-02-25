
class Guest

  def initialize
    @name = [*('a'..'z')].sample(8).join
  end

  def name s
    @name = s
    puts "guest #{s}"
  end

end

