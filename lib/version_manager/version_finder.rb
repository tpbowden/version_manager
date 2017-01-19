require "version_manager/version_number"

module VersionManager
  class VersionFinder
    def call
      load VersionManager.configuration.version_file
      VersionNumber.new Object.const_get(VersionManager.configuration.version_constant)
    end
  end
end
