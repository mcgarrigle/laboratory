
require "forward"

describe Forward do

  describe "#to_s" do

    context "when fully described" do

      subject { Forward.new("ssh", :protocol => :tcp, "127.0.0.1:2022" => "10.0.30.100:22") }

      it "should return netpf string" do
        expect(subject.to_s).to eql "ssh,tcp,127.0.0.1,2022,10.0.30.100,22"
      end

    end

    context "when including badly formed address" do

      subject { Forward.new("ssh", "XXX.0.0.1:2022" => "10.0.30.100:22") }

      it "should error" do
        expect { subject }.to raise_error IPAddr::InvalidAddressError
      end

    end

    context "when defaulting protocol" do

      subject { Forward.new("ssh", "127.0.0.1:2022" => "10.0.30.100:22") }

      it "should return netpf string" do
        expect(subject.to_s).to eql "ssh,tcp,127.0.0.1,2022,10.0.30.100,22"
      end

   end

    context "when defaulting addresses" do

      subject { Forward.new("ssh", ":2022" => ":22") }

      it "should return netpf string" do
        expect(subject.to_s).to eql "ssh,tcp,,2022,,22"
      end

    end

    context "when setting protocol" do

      subject { Forward.new("ssh", :protocol => :udp, "127.0.0.1:2022" => "10.0.30.100:22") }

      it "should return netpf string" do
         expect(subject.to_s).to eql "ssh,udp,127.0.0.1,2022,10.0.30.100,22"
      end

    end # context

  end # describe

end # Forward

