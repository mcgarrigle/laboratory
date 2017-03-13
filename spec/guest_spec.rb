
require "guest"


describe Guest do

  describe "#interface" do

    it "should create an interface" do
      expect(Interface).to receive(:new)
      subject.interface { }
    end

    it "should create all interfaces" do
      expect(Interface).to receive(:new).twice
      subject.interface { }
      subject.interface { }
    end

  end

  describe "#disk" do
  
    it "should create all disks" do
      expect(Disk).to receive(:new).twice.and_return(Disk.new)
      subject.disk { }
      subject.disk { }
    end

    it "should allocate all devices" do
      subject.disk { }
      subject.disk { }
      expect(subject.disks[0].device).to eql :sda
      expect(subject.disks[1].device).to eql :sdb
    end

  end

end
