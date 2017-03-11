
require "vbox"

describe Vbox do

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

end
