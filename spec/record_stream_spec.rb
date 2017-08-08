
require "record_stream"

describe RecordStream do

  describe "#records" do

      subject do
         stream = File.readlines("spec/fixtures/natnetworks").map(&:chomp)
         RecordStream.new(stream)
      end

      it "should return the right number of records" do
         expect(subject.records.size).to eql 2
      end

      it "should return the right number of fields" do
         record = subject.records[0]
         expect(record.size).to eql 7
      end

      it "should return a correct fields" do
         record = subject.records[1]
         expect(record["NetworkName"]).to eql "cluster" 
      end

  end # describe

end # spec

