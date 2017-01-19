module VersionManager
  module Git
    module CLI
      def add *files
        `git add #{files.join(" ")}`
      end

      def commit message
        `git commit -m '#{message}'`
      end

      def tag message
        `git tag -am '#{message}' #{message}`
      end
    end
  end
end
