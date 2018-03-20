
module Plugins

  # simple autoloader

  def self.const_missing(c)
    name = c.to_s.downcase
    load "plugins/#{name}.rb"
    self.const_get(c)
  end

end
