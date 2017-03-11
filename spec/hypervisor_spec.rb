
require "hypervisor"

describe Hypervisor do

  describe "#list" do

    it "calls Vbox#list" do
      expect(Vbox).to receive(:list).with(:vms).and_return({ "{xxxx}" => "foo" })
      expect(Vbox).to receive(:list).with(:runningvms).and_return({})
      subject.list
    end

    it "classifies running vms" do
      allow(Vbox).to receive(:list).with(:vms).and_return({ "{xxxx}" => "foo", "{yyyy}" => "bar" })
      allow(Vbox).to receive(:list).with(:runningvms).and_return({ "{xxxx}" => "foo" })
      list = subject.list
      expect(list[0].state).to eql :running
      expect(list[1].state).to eql :stopped
    end

    #pending "returns a hash of id => name" do
    #  allow(Vbox).to receive(:`).and_return(%Q["foo" {xxxx}\n"bar" {yyyy}\n])
    #  expect(Vbox.list(:vms)).to be == { "{xxxx}" => "foo", "{yyyy}" => "bar" }
    #end

  end

end
