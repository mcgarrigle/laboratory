
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
  # take hash of and convert into commandline args

  describe "#flatten" do
    
    it "returns correct types" do
      args = { :string => "foo", :symbol => :bar, :integer => 123 }
      expect(subject.flatten(args)).to be == '--string "foo" --symbol bar --integer 123'
    end

  end

end
