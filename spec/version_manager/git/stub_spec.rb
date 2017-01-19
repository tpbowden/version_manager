require "version_manager/git/stub"

describe VersionManager::Git::Stub do
  subject { Module.new { extend VersionManager::Git::Stub } }

  describe ".add" do
    it "stores the supplied files" do
      subject.add "file 1", "file 2"
      expect(subject.files).to match_array ["file 1", "file 2"]
    end
  end

  describe ".commit" do
    it "stores the commit message" do
      subject.commit "a message"
      expect(subject.commit_message).to eq "a message"
    end
  end

  describe ".tag" do
    it "stores the tag" do
      subject.tag "a tag"
      expect(subject.tag_message).to eq "a tag"
    end
  end
end
