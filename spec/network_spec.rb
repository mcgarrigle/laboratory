
require "network"

describe Network do

  describe ".new" do
  
    subject { Network.new :management, :hostonly => "10.0.0.0/24" }

    it "should set name as a string" do
      expect(subject.name).to eql "management"
    end

    it "should set ip4" do
      expect(subject.ip4).to eql "10.0.0.0"
    end

    it "should set netmask4" do
      expect(subject.netmask4).to eql "255.255.255.0"
    end

    it "should set prefix4" do
      expect(subject.prefix4).to eql "/24"
    end

  end

  describe "===" do

    let(:a) { Network.new(:a, :hostonly   => "10.1.0.0/24") }
    let(:b) { Network.new(:b, :hostonly   => "10.1.0.0/24") }
    let(:c) { Network.new(:c, :hostonly   => "10.2.0.0/24") }
    let(:d) { Network.new(:d, :natnetwork => "10.2.0.0/24") }

    it "should detect compatible networks" do
      expect(a === b).to be true
    end

    it "should detect incompatible networks" do
      expect(a === c).to be false
    end

    it "should error if another type has the same subnet" do
      expect { c === d }.to raise_error NetworkClashError
    end

  end

end
