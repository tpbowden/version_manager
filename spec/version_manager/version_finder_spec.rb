require "version_manager/version_finder"
require "tempfile"

describe VersionManager::VersionFinder do
  describe "#call" do
    let(:version) { double :version }
    let(:version_string) { "a version string" }
    let(:file) { Tempfile.new "version file" }
    let(:constant) { "SomeModule::SomeClass::MY_VERSION_NUMBER" }
    let(:version_file) {
      <<EOF
module SomeModule
  class SomeClass
    MY_VERSION_NUMBER = "#{version_string}"
  end
end
EOF
    }

    before do
      file.write version_file
      file.rewind
    end

    after do
      file.close
      file.unlink
    end

    before do
      allow(VersionManager).to receive_message_chain("configuration.version_file") { file.path }
      allow(VersionManager).to receive_message_chain("configuration.version_constant") { constant }
      allow(VersionManager::VersionNumber).to receive(:new).with(version_string) { version }
    end

    it "creates a new version number after parsing the supplied file" do
      expect(subject.call).to eq version
    end
  end
end
