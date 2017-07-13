
require "forward"

describe Forward do

  describe "#to_s" do

   context "when fully described" do

     subject { Forward.new("ssh", :protocol => :tcp, "127.0.0.1:2022" => "10.0.30.100:22") }

      it "should return netpf string" do
        expect(subject.to_s).to eql "ssh,tcp,127.0.0.1,2022,10.0.30.100,22"
      end

    end

   context "when defaulting protocol" do

     subject { Forward.new("ssh", "127.0.0.1:2022" => "10.0.30.100:22") }

      it "should return netpf string" do
        expect(subject.to_s).to eql "ssh,tcp,127.0.0.1,2022,10.0.30.100,22"
      end

    end
  end

end
