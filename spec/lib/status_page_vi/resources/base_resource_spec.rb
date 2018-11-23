require "spec_helper"

RSpec.describe StatusPageVi::BaseResource do
  describe "self#pull" do
    before do
      allow_any_instance_of(described_class).to receive(:call).and_return(true)
      allow_any_instance_of(described_class).to receive(:save).and_return(true)

      allow_any_instance_of(described_class).to receive(:timestamp).and_return(Time.now)
      allow_any_instance_of(described_class).to receive(:options).and_return("status" => "good")
      stub_const(
        "StatusPageVi::BaseResource::URL",
        'https://base-resource.com'
      )
    end

    it "calls and saves data" do
      expect_any_instance_of(described_class).to receive(:call)
      expect_any_instance_of(described_class).to receive(:save)
      described_class.pull
    end
  end

  describe "self#print_history" do
    it "raises no Exceptions" do
      expect{ described_class.print_history }.not_to raise_error
    end
  end
end
