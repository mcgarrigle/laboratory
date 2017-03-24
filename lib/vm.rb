
class VM

  attr_accessor :id, :name, :state

  def initialize(id, name)
    @id    = id
    @name  = name
    @state = :unknown
  end

  def to_s
    "%s %7s %s" % [@id, @state, @name]
  end

end
