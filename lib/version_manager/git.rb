require "version_manager/git/cli"
require "version_manager/git/stub"

module VersionManager
  module Git
    extend CLI

    def self.stub_api
      singleton_class.prepend VersionManager::Git::Stub
    end
  end
end
