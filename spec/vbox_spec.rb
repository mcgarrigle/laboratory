
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

  # flatten:
  # takes hash and converts into commandline args

  describe "#flatten" do
    
    it "returns correct types" do
      args = { :string => "foo", :symbol => :bar, :integer => 123 }
      expect(subject.flatten(args)).to be == '--string "foo" --symbol bar --integer 123'
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
