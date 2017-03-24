
require "command"
require "subnet"

describe Command do

  let(:subnet) { subnet = instance_double("Subnet") }

  subject do
    Command.new(subnet)
  end

  context "during initilization" do

    it "should create a new hypervisor" do
      expect(Hypervisor).to receive(:new).and_return(double)
      Command.new(subnet)
    end

  end

  context "on garbage command" do

    xit "should print error"

  end

  context "on list" do

    let(:hypervisor) { instance_double("Hypervisor") }

    before(:each) do
      allow(Hypervisor).to receive(:new).and_return(hypervisor)
    end

    it "should call Hypervisor.list" do
      expect(Hypervisor).to receive(:list).and_return([])
      subject.run("list")
    end

  end

end
