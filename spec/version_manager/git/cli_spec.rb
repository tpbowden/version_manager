require "version_manager/git/cli"

describe VersionManager::Git::CLI do
  subject { Module.new { extend VersionManager::Git::CLI } }

  before do
    allow(subject).to receive(:`)
  end

  describe ".add" do
    it "adds all the files to git" do
      expect(subject).to receive(:`).with("git add foo bar baz")
      subject.add "foo", "bar", "baz"
    end
  end

  describe ".commit" do
    it "commits with the given message" do
      expect(subject).to receive(:`).with("git commit -m 'the message'")
      subject.commit "the message"
    end
  end

  describe ".tag" do
    it "tags with the given tag" do
      expect(subject).to receive(:`).with("git tag -am 'the tag' the tag")
      subject.tag "the tag"
    end
  end
end
