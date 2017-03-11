
require "vbox"

describe Vbox do

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
  # take  hash and converts into commandline args

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
      expect(subject).to receive(:system).with('vboxmanage createvm --register --name "foo"')
      subject.createvm(:name => "foo")
    end

  end

  describe "#method_missing" do

    it "calls system" do
      vbox = Vbox.new("vm-name")
      expect(vbox).to receive(:system).with('vboxmanage foo "vm-name" --bar baz')
      vbox.foo(:bar => :baz)
    end

  end

end
