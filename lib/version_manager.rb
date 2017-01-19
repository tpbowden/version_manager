require "version_manager/configuration"

module VersionManager
  def self.configuration
    @configuration ||= Configuration.new
  end
end
