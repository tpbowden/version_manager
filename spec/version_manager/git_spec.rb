require "version_manager/git"

describe VersionManager::Git do
  describe ".stub_api" do
    it "prepends the stubbed git module" do
      described_class.stub_api
      expect(described_class.singleton_class.included_modules.first).to be VersionManager::Git::Stub
    end
  end
end
