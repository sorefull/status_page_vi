require "spec_helper"

RSpec.describe StatusPageVi::PullService do
  describe "self#call" do
    it "copies chached files" do
      expect(StatusPageVi::BitBucket).to receive(:pull)
      expect(StatusPageVi::Github).to receive(:pull)
      expect(StatusPageVi::RubyGems).to receive(:pull)
      expect(StatusPageVi::CloudFlareStatus).to receive(:pull)
      described_class.call("ALL")
    end
  end
end
