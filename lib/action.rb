
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

  def _create(guest)
    @hypervisor.create(guest)
    @laboratory.plugins.each { |plugin| plugin.create(guest) }
  end

  def up(guest)
    puts "up #{guest.name} => #{guest.status}"
    case guest.status
    when :disabled then return
    when :running  then return
    when :defined  then _create(guest)
    end
    @hypervisor.start(guest)
  rescue => e
    puts e.inspect
  end

  def down(guest)
    puts "down #{guest.name} => #{guest.status}"
    @hypervisor.stop(guest) if guest.status == :running
  rescue => e
    puts e.inspect
  end

  def delete(guest)
    puts "delete #{guest.name} => #{guest.status}"
    return if guest.status == :defined
    self.down(guest)
    sleep 5
    @hypervisor.destroy(guest)
  rescue => e
    puts e.inspect
  end

end
