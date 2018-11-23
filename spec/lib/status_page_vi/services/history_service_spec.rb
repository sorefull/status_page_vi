require "spec_helper"

RSpec.describe StatusPageVi::HistoryService do
  describe "self#call" do
    it "copies chached files" do
      expect(StatusPageVi::BitBucket).to receive(:print_history)
      expect(StatusPageVi::Github).to receive(:print_history)
      expect(StatusPageVi::RubyGems).to receive(:print_history)
      expect(StatusPageVi::CloudFlareStatus).to receive(:print_history)
      described_class.call("ALL")
    end
  end
end
