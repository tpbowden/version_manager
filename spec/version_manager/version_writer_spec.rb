require "version_manager/version_writer"

describe VersionManager::VersionWriter do
  let(:version) { double :version, starting_version: "starting version", to_tag: "a tag", to_s: "a string" }
  let(:history_file) { Tempfile.new "history" }
  let(:version_file) { Tempfile.new "version" }
  let(:tagger) { spy :tagger }
  let(:updated_history_file) {
    <<EOF
== a tag (#{Date.today.strftime('%d %B %Y')})

* This is a change
EOF
  }
  let(:initial_version_file) {
    <<EOF
module Something
  VERSION = "starting version"
end
EOF
  }
  let(:updated_version_file) {
    <<EOF
module Something
  VERSION = "a string"
end
EOF
  }

  before do
    allow(VersionManager::VersionTagger).to receive(:new) { tagger }
    version_file.write(initial_version_file)
    version_file.rewind
    history_file.write("* This is a change\n")
    history_file.rewind
    allow(VersionManager).to receive_message_chain("configuration.history_file") { history_file.path }
    allow(VersionManager).to receive_message_chain("configuration.version_file") { version_file.path }
  end

  after do
    history_file.close
    history_file.unlink
    version_file.close
    version_file.unlink
  end

  describe "#call" do
    it "writes the history file with the new version" do
      subject.call version
      expect(File.read history_file).to eq updated_history_file
    end

    it "writers the version file with the new version" do
      subject.call version
      expect(File.read version_file).to eq updated_version_file
    end

    it "calls the version tagger" do
      subject.call version
      expect(tagger).to have_received(:call).with(version)
    end
  end
end
