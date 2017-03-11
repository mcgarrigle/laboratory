
class Dvd

  attr_accessor :device, :media

  def initialize(device = :sr0, media = nil)
    @media = media
  end

end
