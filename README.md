# Version Manager

Automatically manage version updates and tagging. The new version will be written to your version file,
history file and as a tagged git commit.

## Dependencies

* Ruby >= 2.2
* Rake

## Installation

```ruby

# In Gemfile

group :development do
  gem "version_manager"
end

# In a Rake configuration file

require "version_manager/rake_task"

VersionManager::RakeTask.new(:release) do |config| # Argument is the namespace for tasks
  config.version_file = "lib/version.rb" # Path to your version file
  config.version_constant = "VERSION" # Version constant including namespaces
  config.history_file = "history.rdoc" # History file to be updated
  config.tag_format = "v%s" # %s will be replaced with the new version as tag names
  config.logger = Logger.new # Replace the logger to turn off / modify stdout logging
end

```

## Usage

```

bundle exec rake release:patch # Patch release eg 1.2.3 => 1.2.4
bundle exec rake release:minor # Minor release eg 1.2.3 => 1.3.0
bundle exec rake release:major # Major release eg 1.2.3 => 2.0.0

```

## Configuration

### `config.version_file`

The file which will be passed to `load` in order to load your current version number. It should be an absoltue
file path or relative to your project's root

### `config.version_constant`

The constant which will be loaded as the current version. For example, if your version number is in a module
called `MyModule` as the constant `MY_VERSION`, the `version_constant` would be `"MyModule::MY_VERSION"` (as a string)

### `config.history_file`

Path to your history file. Currently only supports rdoc format.

### `config.tag_format`

The format git tags will be given after version has been updated. `%s` will be replaced with the version number

### `config.logger`

The logger to use when printing info messages. By default this just logs the messages with no formatting to STDOUT.
If you want to suppress logging you can just use `Logger.new "/dev/null"`
