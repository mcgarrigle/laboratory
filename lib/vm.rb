
class VM

  attr_accessor :id, :name, :state

  def initialize(id, name)
    @id    = id
    @name  = name
    @state = :unknown
  end

end
