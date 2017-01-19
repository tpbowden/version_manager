require "simplecov"
require "logger"
require "version_manager"
require "version_manager/git"

SimpleCov.start do
  coverage_dir "coverage/cucumber"
  minimum_coverage 100
end

Before do
  VersionManager::Git.stub_api
  VersionManager.configuration.logger = Logger.new "/dev/null"
end

After do
  @version_file.close
  @version_file.unlink
  @history_file.close
  @history_file.unlink
end
