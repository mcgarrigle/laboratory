
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

end
