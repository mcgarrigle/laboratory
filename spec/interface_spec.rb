
require "interface"

describe Interface do

  describe "#network" do

    it "should set connection for bridged" do
      subject.bridged
      expect(subject.connection).to eql :bridged
      expect(subject.name).to eql ""
    end

    it "should set connection for nat" do
      subject.nat
      expect(subject.connection).to eql :nat
      expect(subject.name).to eql ""
    end

    it "should set network_name for intnet" do
      subject.intnet :cluster
      expect(subject.connection).to eql :intnet
      expect(subject.name).to eql "cluster"
    end

    it "should set network_name for natnetwork" do
      subject.natnetwork :application
      expect(subject.connection).to eql :natnetwork
      expect(subject.name).to eql "application"
    end

    it "should set network_name for hostonly" do
      subject.hostonly "management"
      expect(subject.connection).to eql :hostonly
      expect(subject.name).to eql "management"
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
