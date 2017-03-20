
require "command"

describe Command do

  context "during initilization" do

    it "should create a new hypervisor" do
      expect(Hypervisor).to receive(:new).and_return(double)
      Command.new
    end

  end

  context "on garbage command" do

    it "should print error"

  end

  context "on list" do

    let(:hypervisor) { instance_double("Hypervisor") }

    before(:each) do
      allow(Hypervisor).to receive(:new).and_return(hypervisor)
    end

    it "should call Hypervisor#list" do
      expect(hypervisor).to receive(:list).and_return([])
      subject.run("list")
    end

  end

end
