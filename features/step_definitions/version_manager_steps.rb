require "tempfile"
require "version_manager"
require "version_manager/version_updater"

Given "there is a version file at version 1.2.3" do
  @version_file = Tempfile.new "version"
  @version_file.write <<EOF
module SomeModule
  VERSION = "1.2.3"
end
EOF
  @version_file.rewind
  VersionManager.configuration.version_file = @version_file.path
  VersionManager.configuration.version_constant = "SomeModule::VERSION"
end

Given "there is a history file" do
  @history_file = Tempfile.new "history"
  @history_file.write <<EOF
* Some changes
EOF
  @history_file.rewind
  VersionManager.configuration.history_file = @history_file.path
end

When(/I increment the (.+) version/) do |version_type|
  VersionManager::VersionUpdater.new.call version_type
  Object.send(:remove_const, :SomeModule)
end

Then(/the project is tagged with (.+)/) do |new_version|
  expect(VersionManager::Git.files).to match_array [@version_file.path, @history_file.path]
  expect(VersionManager::Git.commit_message).to eq "Update version to v#{new_version}"
  expect(VersionManager::Git.tag_message).to eq "v#{new_version}"
end

Then(/the history file has been updated with (.+)/) do |new_version|
  date = Date.today.strftime("%d %B %Y")
  expect(@history_file.read).to eq <<EOF
== v#{new_version} (#{date})

* Some changes
EOF
end

Then(/the version file has been updated with (.+)/) do |new_version|
  expect(@version_file.read).to eq <<EOF
module SomeModule
  VERSION = "#{new_version}"
end
EOF
end
