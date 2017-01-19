require "version_manager/version_tagger"

describe VersionManager::VersionTagger do
  describe "#call" do
    let(:version) { double :version, to_tag: "tag name" }
    let(:version_file) { double :version_file }
    let(:history_file) { double :history_file }
    let(:logger) { double :logger, info: true }

    before do
      allow(VersionManager::Git).to receive(:add)
      allow(VersionManager::Git).to receive(:commit)
      allow(VersionManager::Git).to receive(:tag)
      allow(VersionManager).to receive_message_chain("configuration.history_file") { history_file }
      allow(VersionManager).to receive_message_chain("configuration.version_file") { version_file }
      allow(VersionManager).to receive_message_chain("configuration.logger") { logger }
    end

    it "adds the history and version files" do
      expect(VersionManager::Git).to receive(:add).with(history_file, version_file)
      subject.call version
    end

    it "commits the files" do
      expect(VersionManager::Git).to receive(:commit).with("Update version to tag name")
      subject.call version
    end

    it "tags with the new version" do
      expect(VersionManager::Git).to receive(:tag).with("tag name")
      subject.call version
    end
  end
end
