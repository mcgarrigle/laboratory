
require "forward"

describe Forward do

  describe "#to_s" do

   subject { Forward.new("ssh", "127.0.0.1:2022" => "10.0.30.100:22") }

    it "should return " do
      expect(subject.to_s).to eql "ssh,tcp,127.0.0.1,2022,10.0.30.100,22"
    end

  end

end
