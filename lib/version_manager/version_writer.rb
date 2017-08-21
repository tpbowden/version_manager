require "date"
require "version_manager/version_tagger"

module VersionManager
  class VersionWriter
    def call version
      File.write version_file, updated_version_file(version)
      File.write history_file, updated_history_file(version) if File.exist?(history_file)
      VersionTagger.new.call version
    end

    def updated_version_file new_version
      File.read(version_file).gsub(new_version.starting_version, new_version.to_s)
    end

    def updated_history_file new_version
      current_history = File.read history_file
      date = Date.today.strftime("%d %B %Y")
      "== #{new_version.to_tag} (#{date})\n\n#{current_history}"
    end

    private

    def history_file
      VersionManager.configuration.history_file
    end

    def version_file
      VersionManager.configuration.version_file
    end
  end
end
