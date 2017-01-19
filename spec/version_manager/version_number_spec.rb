require "version_manager/version_number"

describe VersionManager::VersionNumber do
  subject { described_class.new "1.2.3" }

  describe "#initialize" do
    it "parses the major version number" do
      expect(subject.major).to eq 1
    end

    it "parses the minor version number" do
      expect(subject.minor).to eq 2
    end

    it "parses the patch version number" do
      expect(subject.patch).to eq 3
    end
  end

  describe "#inc_major" do
    it "increases the major version number by 1" do
      subject.inc_major
      expect(subject.major).to eq 2
    end

    it "resets the minor version to 0" do
      subject.inc_major
      expect(subject.minor).to eq 0
    end

    it "resets the patch version to 0" do
      subject.inc_major
      expect(subject.patch).to eq 0
    end
  end

  describe "#inc_major" do
    it "leaves the major version as it was" do
      subject.inc_minor
      expect(subject.major).to eq 1
    end

    it "increases the minor version number by 1" do
      subject.inc_minor
      expect(subject.minor).to eq 3
    end

    it "resets the patch version to 0" do
      subject.inc_minor
      expect(subject.patch).to eq 0
    end
  end

  describe "#inc_patch" do
    it "leaves the major version as it was" do
      subject.inc_patch
      expect(subject.major).to eq 1
    end

    it "leaves the minor version as it was" do
      subject.inc_patch
      expect(subject.minor).to eq 2
    end

    it "increases the patch version by 1" do
      subject.inc_patch
      expect(subject.patch).to eq 4
    end
  end

  describe "#to_s" do
    it "reconstructs the version string" do
      expect(subject.to_s).to eq "1.2.3"
    end
  end

  describe "#to_tag" do
    before do
      allow(VersionManager).to receive_message_chain("configuration.tag_format") { "a tag %s" }
    end

    it "interpolates the string version into the tag format" do
      expect(subject.to_tag).to eq "a tag 1.2.3"
    end
  end
end
