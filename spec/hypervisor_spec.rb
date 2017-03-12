
require "hypervisor"
require "guest"

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

  describe "#create" do

    let(:vbox) { vbox = instance_double("Vbox") }

    before (:each) do
      @guest = Guest.new
      @guest.name = "foo"
      @guest.dvd {}
      @guest.disk {}

      allow(Vbox).to receive(:new).and_return(vbox)
      allow(vbox).to receive(:createvm)
      allow(vbox).to receive(:modifyvm)
      allow(vbox).to receive(:storagectl)
      allow(vbox).to receive(:storageattach)
      allow(vbox).to receive(:createhd)
    end

    it "should create vm" do
      expect(vbox).to receive(:createvm)
      subject.create(@guest)
    end

    it "should create a disk" do
      expect(vbox).to receive(:createhd)   # TODO make better
      subject.create(@guest)
    end

    it "should attach a disk" do
      expect(vbox).to receive(:storageattach).with(hash_including(:storagectl => "SATA", :type => :hdd))
      subject.create(@guest)
    end

    it "should attach a dvd" do
      expect(vbox).to receive(:storageattach).with(hash_including(:storagectl => "IDE", :type => :dvddrive))
      subject.create(@guest)
    end

  end

end
