require "version_manager/version_finder"
require "version_manager/version_writer"

module VersionManager
  class VersionUpdater
    def call update_type
      v = VersionFinder.new.call
      v.send(:"inc_#{update_type}")
      VersionWriter.new.call v
    end
  end
end
