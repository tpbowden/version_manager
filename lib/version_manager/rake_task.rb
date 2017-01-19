require "rake/tasklib"
require "version_manager"
require "version_manager/version_updater"

module VersionManager
  class RakeTask < Rake::TaskLib
    EXAMPLES = {
      major: "1.2.3 => 2.0.0",
      minor: "1.2.3 => 1.3.0",
      patch: "1.2.3 => 1.2.4",
    }.freeze

    # rubocop: disable Metrics/MethodLength
    def initialize task_namespace = :release
      yield(VersionManager.configuration) if block_given?
      namespace task_namespace do
        [:major, :minor, :patch].each do |v|
          desc "Increment your #{v} version number eg #{EXAMPLES[v]}"
          task v do
            VersionUpdater.new.call(v)
          end
        end
      end
    end
    # rubocop: enable all
  end
end
