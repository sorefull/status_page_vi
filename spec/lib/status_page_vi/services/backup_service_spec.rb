require "spec_helper"

RSpec.describe StatusPageVi::BackupService do
  before do
    allow(FileUtils).to receive(:cp)
  end

  describe "self#backup" do
    it "copies chached files" do
      expect(FileUtils).to receive(:cp).with(StatusPageVi::BitBucket.cache_file_path, "backups_folder/BitBucket.json")
      expect(FileUtils).to receive(:cp).with(StatusPageVi::Github.cache_file_path, "backups_folder/Github.json")
      expect(FileUtils).to receive(:cp).with(StatusPageVi::RubyGems.cache_file_path, "backups_folder/RubyGems.json")
      expect(FileUtils).to receive(:cp).with(StatusPageVi::CloudFlareStatus.cache_file_path, "backups_folder/CloudFlareStatus.json")
      described_class.backup("backups_folder", "ALL")
    end
  end

  describe "self#restore" do
    before do
      allow(StatusPageVi::RubyGems).to receive(:update_storage)
      allow(StatusPageVi::BackupFileValidator).to receive(:new)
        .and_return(
          double(
            'BackupFileValidator',
            {
              valid_backup?: true,
              resource: StatusPageVi::RubyGems,
              json_data: "{}"
            }
          )
        )
    end

    it "updates storage" do
      expect(StatusPageVi::RubyGems).to receive(:update_storage).with("{}")
      described_class.restore("backups_folder/RubyGems.json")
    end
  end
end
