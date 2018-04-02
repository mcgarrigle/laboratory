
require "command"
require "laboratory"

describe Command do

  let(:laboratory) { 
    laboratory = instance_double("Laboratory")
    allow(laboratory).to receive(:guests).and_return([])
    laboratory
  }

  subject do
    Command.new(laboratory)
  end

  context "during initilization" do

    it "should create a new hypervisor" do
      expect(Virtualbox).to receive(:new).and_return(double)
      Command.new(laboratory)
    end

  end

  context "on garbage command" do

    xit "should print error"

  end

  context "on list" do

    let(:hypervisor) { instance_double("Hypervisor") }

    before(:each) do
      allow(Virtualbox).to receive(:new).and_return(hypervisor)
    end

    xit "should call Hypervisor.list" do
      expect(Virtualbox).to receive(:list).and_return([])
      subject.run("list")
    end

  end

end
