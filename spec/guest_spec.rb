
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

  describe "#boot" do

    it "should set order" do
      subject.boot = [:dvd, :disk]
      expect(subject.boot).to eql [:dvd, :disk]
    end

    it "should reject non-arrays" do
      expect { subject.boot = "shoe" }.to raise_error(ArgumentError)
    end

    it "should reject order if device not known" do
      expect { subject.boot = [:dvd, :majick] }.to raise_error(ArgumentError)
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
