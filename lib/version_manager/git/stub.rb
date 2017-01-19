module VersionManager
  module Git
    module Stub
      def add *files
        @files = files
      end

      def commit message
        @commit_message = message
      end

      def tag message
        @tag_message = message
      end

      def files
        @files
      end

      def commit_message
        @commit_message
      end

      def tag_message
        @tag_message
      end
    end
  end
end
