require "spec_helper"

RSpec.describe StatusPageVi::CLI do
  before do
    stub_const(
      "StatusPageVi::RESOURCES",
      { "BitBucket" => StatusPageVi::BitBucket }
    )

    allow(StatusPageVi::PullService).to receive(:call)
    allow(StatusPageVi::HistoryService).to receive(:call)
    allow(StatusPageVi::BackupService).to receive(:backup)
    allow(StatusPageVi::BackupService).to receive(:restore)
  end

  describe "#resources" do
    it "outputs avaliable resource" do
      expect { subject.resources }.to output("BitBucket : #{StatusPageVi::BitBucket::URL}\n").to_stdout
    end
  end

  describe "#valid_resource?" do
    it { expect(subject.send(:valid_resource?, "ALL")).to be_truthy }
    it { expect(subject.send(:valid_resource?, "BitBucket")).to be_truthy }
    it { expect(subject.send(:valid_resource?, "Facebook")).to be_falsey }
  end

  describe "#pull" do
    context "without parameters" do
      it "calls StatusPageVi::PullService with ALL option" do
        expect(StatusPageVi::PullService).to receive(:call).with("ALL")
        subject.pull
      end
    end

    context "with existing resource" do
      it "calls StatusPageVi::PullService with ALL option" do
        expect(StatusPageVi::PullService).to receive(:call).with(StatusPageVi::BitBucket)
        subject.pull("BitBucket")
      end
    end
  end

  describe "#history" do
    it "calls StatusPageVi::HistoryService" do
      expect(StatusPageVi::HistoryService).to receive(:call).with(StatusPageVi::BitBucket)
      subject.history("BitBucket")
    end
  end

  describe "#backup" do
    it "calls StatusPageVi::BackupService#backup" do
      expect(StatusPageVi::BackupService).to receive(:backup).with("backup_folder", StatusPageVi::BitBucket)
      subject.backup("backup_folder", "BitBucket")
    end
  end

  describe "#restore" do
    it "calls StatusPageVi::BackupService#restore" do
      expect(StatusPageVi::BackupService).to receive(:restore).with("backup_folder")
      subject.restore("backup_folder")
    end
  end
end
