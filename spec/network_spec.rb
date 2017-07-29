
require "network"

describe Network do

  describe ".new" do
  
    subject { Network.new :management, :hostonly => "10.0.0.0/24" }

    it "should set name" do
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

end
