
require 'virtualbox'

class Action

  def initialize(laboratory)
    @laboratory = laboratory
    @hypervisor = Virtualbox.new
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
    intent(guest, "up")
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
    intent(guest, "down")
    @hypervisor.stop(guest) if guest.status == :running
  rescue => e
    puts e.inspect
  end

  def delete(guest)
    intent(guest, "delete")
    return if guest.status == :defined
    self.down(guest)
    sleep 5
    @hypervisor.destroy(guest)
  rescue => e
    puts e.inspect
  end

  def intent(guest, state)
    puts "#{guest.name} [#{guest.status}] => [#{state}]"
  end

end
