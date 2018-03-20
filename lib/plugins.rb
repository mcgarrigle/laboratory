
module Plugins

  def self.load(c)
    name = c.to_s.downcase
    Kernel.load "plugins/#{name}.rb"
    self.const_get(name.capitalize)
  end

end
