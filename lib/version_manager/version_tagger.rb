require "version_manager/git"

module VersionManager
  class VersionTagger
    def call version
      logger.info "Committing and tagging..."
      tag version
      logger.info "Done"
      logger.info "Run `git push origin master --tags` to deploy your new tag (#{version.to_tag})"
    end

    private

    def tag version
      Git.add history_file, version_file
      Git.commit "Update version to #{version.to_tag}"
      Git.tag version.to_tag
    end

    def history_file
      VersionManager.configuration.history_file
    end

    def version_file
      VersionManager.configuration.version_file
    end

    def logger
      VersionManager.configuration.logger
    end
  end
end
