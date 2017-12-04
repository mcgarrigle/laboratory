
require "adapter"

include Adapter

describe Adapter do

  describe "#nat" do

    it "should return nat as the key" do
      expect(nat.keys.first).to  eql :nat
    end

  end

  describe "#bridged" do

    it "should return bridged as the key" do
      expect(bridged.keys.first).to  eql :bridged
    end

  end

  describe "#intnet" do

    subject { intnet(:foo) }

    it "should return intnet as the key" do
      expect(subject.keys.first).to  eql :intnet
    end

    it "should return network config as the value" do
      expect(subject.values.first).to  eql({ :intnet => "foo" })
    end

  end

  describe "#natnetwork" do

    subject { natnetwork(:foo) }

    it "should return nat-network as the key" do
      expect(subject.keys.first).to  eql :natnetwork
    end

    it "should return network config as the value" do
      expect(subject.values.first).to  eql({ "nat-network" => "foo" }) 
    end

  end

  describe "#hostonly" do

    subject { hostonly(:foo) }

    it "should return :hostonly as the key" do
      expect(subject.keys.first).to  eql :hostonly
    end

    it "should return network config as the value" do
      expect(subject.values.first).to  eql({ :hostonlyadapter => "foo" }) 
    end

  end

end
