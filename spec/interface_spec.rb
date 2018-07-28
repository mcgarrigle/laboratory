
require "interface"

describe Interface do

  subject { Interface.new("node.foo.local", 666) }

  describe "#network" do

    it "should set connection for bridged" do
      subject.bridged :en0
      expect(subject.connection).to eql :bridged
      expect(subject.adapter).to eql "bridgeadapter666"
      expect(subject.name).to eql "en0"
    end

    it "should set connection for nat" do
      subject.nat
      expect(subject.connection).to eql :nat
      expect(subject.name).to eql ""
    end

    it "should set network_name for intnet" do
      subject.intnet :cluster
      expect(subject.connection).to eql :intnet
      expect(subject.adapter).to eql "intnet666"
      expect(subject.name).to eql "cluster"
    end

    it "should set network_name for natnetwork" do
      subject.natnetwork :application
      expect(subject.connection).to eql :natnetwork
      expect(subject.adapter).to eql "nat-network666"
      expect(subject.name).to eql "application"
    end

    it "should set network_name for hostonly vboxnet0" do
      subject.hostonly "vboxnet0"
      expect(subject.connection).to eql :hostonly
      expect(subject.adapter).to eql "hostonlyadapter666"
      if Gem.win_platform?
        expect(subject.name).to eql "VirtualBox Host-Only Ethernet Adapter"
      else
        expect(subject.name).to eql "vboxnet0"
      end
    end

    it "should set network_name for hostonly vboxnet1" do
      subject.hostonly "vboxnet1"
      expect(subject.connection).to eql :hostonly
      expect(subject.adapter).to eql "hostonlyadapter666"
      if Gem.win_platform?
        expect(subject.name).to eql "VirtualBox Host-Only Ethernet Adapter #2"
      else
        expect(subject.name).to eql "vboxnet1"
      end
    end

  end

  describe "#mac" do

    it "should generate a mac address" do
      subject = Interface.new("bar.foo.local", 1)
      expect(subject.mac).to eql("02119F998582")
    end

    it "should generate a different mac address" do
      subject = Interface.new("bar.foo.local", 2)
      expect(subject.mac).to eql("02CD29F78ED0")
    end

    it "should generate another mac address" do
      subject = Interface.new("baz.foo.local", 1)
      expect(subject.mac).to eql("023B8BDAA608")
    end

  end

  describe "#ip4=" do

    context "when supplying CIDR address" do

      it "should set ip4" do
        subject.ip4 = "10.0.0.1/24"
        expect(subject.ip4).to eql "10.0.0.1"
      end

      it "should set netmask4" do
        subject.ip4 = "10.0.0.1/24"
        expect(subject.netmask4).to eql "255.255.255.0"
      end

      it "should set prefix4" do
        subject.ip4 = "10.0.0.1/24"
        expect(subject.prefix4).to eql "/24"
      end

    end

  end

  describe "#forward" do

    it "should contain an array of one" do
      subject.forward("guestssh", ":2222" => ":22")
      expect(subject.rules.map(&:to_s)).to eql ["guestssh,tcp,,2222,,22"]
    end

    it "should contain an array of two" do
      subject.forward("guestssh", ":2222" => ":22")
      subject.forward("guestscp", ":3333" => ":33")
      expect(subject.rules.map(&:to_s)).to eql ["guestssh,tcp,,2222,,22", "guestscp,tcp,,3333,,33"]
    end

  end

end
