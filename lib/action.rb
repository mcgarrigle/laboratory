
require 'hypervisor'

class Action

  def initialize(laboratory)
    @hypervisor = Hypervisor.new
    vms = Hypervisor.status
    @laboratory = laboratory
    @laboratory.guests.each {|g| g.status = vms[g.name] }
    # @networks = Vbox.networks
  end

  def list
    @laboratory.guests.each do |guest|
      puts guest
    end
  end

  def up(guest)
    puts "create #{guest.name} #{guest.status}"
    if guest.status.nil?
      puts "create #{guest.name}"
      @hypervisor.create(guest) 
    end
    unless guest.status == :running
      puts "starting #{guest.name}"
      @hypervisor.start(guest)
    end 
  end

  def down(guest)
    @hypervisor.stop(guest)
  rescue
  end

  def delete(guest)
    @hypervisor.stop(guest)
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
