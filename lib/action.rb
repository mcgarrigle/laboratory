
require 'hypervisor'

class Action

  def initialize(laboratory)
    @laboratory = laboratory
    @hypervisor = Hypervisor.new
  end

  def list
    @laboratory.guests.each do |guest|
      puts guest
    end
  end

  def dump(guest)
    puts guest
  end

  def up(guest)
    puts "up #{guest.name}"
    case guest.status
    when :running then return
    when nil      then @hypervisor.create(guest)
    end
    @laboratory.plugins.each {|plugin| plugin.create(guest) }
    @hypervisor.start(guest)
  rescue => e
    puts e.inspect
  end

  def down(guest)
    puts "down #{guest.name} #{guest.status}"
    return if guest.status == :stopped
    @hypervisor.stop(guest)
  rescue
  end

  def delete(guest)
    puts "delete #{guest.name} #{guest.status}"
    case guest.status
    when nil      then return
    when :running then @hypervisor.stop(guest)
    end
    @hypervisor.destroy(guest)
  rescue
  end

end
