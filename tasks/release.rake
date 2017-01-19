require "version_manager/rake_task"

VersionManager::RakeTask.new do |config|
  config.version_file = "lib/version_manager/version.rb"
  config.version_constant = "VersionManager::VERSION"
end
