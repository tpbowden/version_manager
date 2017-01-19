module VersionManager
  class VersionNumber
    attr_reader :major, :minor, :patch, :starting_version

    def initialize version_string
      @starting_version = version_string
      @major, @minor, @patch = version_string.split(".").map(&:to_i)
    end

    def inc_major
      @major += 1
      @minor = 0
      @patch = 0
    end

    def inc_minor
      @minor += 1
      @patch = 0
    end

    def inc_patch
      @patch += 1
    end

    def to_s
      "#{@major}.#{@minor}.#{@patch}"
    end

    def to_tag
      VersionManager.configuration.tag_format % to_s
    end
  end
end
