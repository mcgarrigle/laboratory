
require "hypervisor"

describe Hypervisor do

  describe "#list" do

    it "calls Vbox#list" do
      expect(Vbox).to receive(:list).twice.and_return({})
      subject.list
    end

    it "classifies running vms" do
      allow(Vbox).to receive(:list).with(:vms).and_return({ "{xxxx}" => "foo", "{yyyy}" => "bar" })
      allow(Vbox).to receive(:list).with(:runningvms).and_return({ "{xxxx}" => "foo" })
      list = subject.list
      expect(list[0].state).to eql :running
      expect(list[1].state).to eql :stopped
    end

  end

end
