
require 'hypervisor'

class Action

  def initialize(laboratory)
    @laboratory = laboratory
    @hypervisor = Hypervisor.new
    # @networks = Vbox.networks
  end

  def list
    @laboratory.guests.each do |guest|
      puts guest
    end
  end

  def up(guest)
    puts "up #{guest.name} #{guest.status}"
    case guest.status
    when :running then return
    when nil      then @hypervisor.create(guest)
    end
    @hypervisor.start(guest)
  rescue
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

  def ssh(host)
    # rules = @laboratory.guests.map {|g| g.interfaces }.map {|a| a.map {|i| i.rules } }.flatten
    # rules = @laboratory.all.guests.interfaces.rules
    rules = []
    @laboratory.guests.each do |g|
      g.interfaces.each do |i|
        i.rules.each do |r|
          rules << r
        end
      end
    end
    p rules
    ssh_rule = rules.select {|r| r.name == "ssh" }.first
    p ssh_rule
  end

end
