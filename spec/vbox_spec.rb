
require "vbox"

describe Vbox do

  subject { Vbox.new("foo") }

  # string:
  # takes a scalar and adds quotes if a string

  describe "#string" do
    
    it "returns quotes for strings" do
      expect(subject.string('foo')).to be == '"foo"'
    end

    it "returns bareword for symbols" do
      expect(subject.string(:foo)).to be == 'foo'
    end

    it "returns string for numeric" do
      expect(subject.string(123)).to be == '123'
    end

  end

  # argv:
  # takes hash and converts into commandline args

  describe "#argv" do
    
    it "returns correct types" do
      args = { :string => "foo", :symbol => :bar, :integer => 123 }
      expect(subject.argv(args)).to be == ' --string "foo" --symbol bar --integer 123'
    end

    it "returns empty string" do
      args = {}
      expect(subject.argv(args)).to be == ''
    end

  end

  describe "#command" do

    it "calls system" do
      expect(subject).to receive(:system).with('vboxmanage foo --bar baz')
      subject.command("foo", :bar => :baz)
    end

  end

  describe "#createvm" do

    it "calls system adding --register" do
      expect(subject).to receive(:system).with('vboxmanage createvm --register --name "foo" --bar baz')
      subject.createvm(:bar => :baz)
    end

  end

  describe "#startvm" do

    it "calls system" do
      expect(subject).to receive(:system).with('vboxmanage startvm "foo" --type headless')
      subject.startvm
    end

  end

  describe "#stopvm" do

    it "calls controlvm" do
      expect(subject).to receive(:system).with('vboxmanage controlvm "foo" acpipowerbutton')
      subject.stopvm
    end

    it "calls controlvm with :poweroff" do
      expect(subject).to receive(:system).with('vboxmanage controlvm "foo" poweroff')
      subject.stopvm(:poweroff)
    end

    it "raise if wrong parameter" do
      expect { subject.stopvm(:notright) }.to raise_error(RuntimeError)
    end

  end

  # TODO Moar tests

  describe ".list" do

    it "calls vboxmanage" do
      expect(Vbox).to receive(:`).with('vboxmanage list vms').and_return('"foo" {xxxx}')
      Vbox.list(:vms)
    end

    it "returns a hash of id => name" do
      allow(Vbox).to receive(:`).and_return(%Q["foo" {xxxx}\n"bar" {yyyy}\n])
      expect(Vbox.list(:vms)).to be == { "{xxxx}" => "foo", "{yyyy}" => "bar" }
    end

  end

end
