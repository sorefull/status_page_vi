require "spec_helper"

RSpec.describe StatusPageVi::Github do
  let(:file) { File.open("#{__dir__}/../../../mocked_data/github.html") }

  before do
    allow_any_instance_of(Kernel).to receive(:open).and_return(file)
  end

  describe "#call" do
    it "requests data from resource and stores it in instance variables" do
      subject.call
      expect(subject.timestamp).to_not be(nil)
      expect(subject.options).to eq({ "status"=>"good" })
    end
  end

  describe "#save" do
    before do
      allow(described_class).to receive(:write_to_service_file).and_return(true)
    end

    let(:expected_data_to_be_stored) {
      { "2018-11-23 19:24:38.465389000 +0100" => { "status"=>"good" } }
    }

    it "saves new data to the service file" do
      subject.timestamp = "2018-11-23 19:24:38.465389000 +0100"
      subject.options = { "status" => "good" }

      expect(described_class).to receive(:write_to_service_file)
        .with(expected_data_to_be_stored)

      subject.save
    end
  end
end
