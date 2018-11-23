require "spec_helper"

RSpec.describe StatusPageVi::BackupFileValidator do
  let(:valid_backup_path) { "#{__dir__}/../../../mocked_data/BitBucket.json" }
  let(:invalid_extention_backup_path) { "#{__dir__}/../../../mocked_data/BitBucket.data" }
  let(:invalid_name_backup_path) { "#{__dir__}/../../../mocked_data/unknown.json" }
  let(:invalid_data_backup_path) { "#{__dir__}/../../../mocked_data/Github.json" }

  describe "self#valid_backup?" do
    it { expect(described_class.new(valid_backup_path).valid_backup?).to be_truthy }
    it { expect(described_class.new(invalid_extention_backup_path).valid_backup?).to be_falsey }
    it { expect(described_class.new(invalid_name_backup_path).valid_backup?).to be_falsey }
    it { expect(described_class.new(invalid_data_backup_path).valid_backup?).to be_falsey }

    context "when backup is valid" do
      let(:validator) { described_class.new(valid_backup_path) }
      let(:json_data) {
        { "2018-11-23 14:31:48 +0100" => { "status" => "good" } }
      }

      before do
        validator.valid_backup?
      end

      it { expect(validator.resource).to eq(StatusPageVi::BitBucket) }
      it { expect(validator.json_data).to eq(json_data) }
    end
  end

end
