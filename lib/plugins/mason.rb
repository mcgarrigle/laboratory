
require 'net/http'
require 'json'

module Plugins

  class Mason

    def initialize(options = {:api => "http://localhost:9090"})
      @uri = URI(options[:api])
    end

    def create(guest)
      puts "mason: create #{guest.name}"
      interfaces = guest.interfaces.map {|i| { :mac => i.mac, :ip => i.ip4, :netmask => i.netmask4 } }
      hash = {:fqdn => guest.name, :interfaces => interfaces }
      res = Net::HTTP.start(@uri.hostname, @uri.port) { |http|
        http.put("/node/#{guest.name}", hash.to_json)
      }
    end

    def start(guest)
    end

    def stop(guest)
    end

    def destroy(guest)
    end

  end

end
