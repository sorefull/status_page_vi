require "spec_helper"

RSpec.describe StatusPageVi::BaseService do
  let(:all_services) {
    [
      StatusPageVi::BitBucket,
      StatusPageVi::CloudFlareStatus,
      StatusPageVi::Github,
      StatusPageVi::RubyGems
    ]
  }

  describe "self#resources" do
    it { expect(described_class.resources("ALL")).to eq(all_services) }
    it { expect(described_class.resources(StatusPageVi::BitBucket)).to eq([ StatusPageVi::BitBucket ]) }
  end
end
