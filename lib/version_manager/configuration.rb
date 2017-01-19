require "logger"

module VersionManager
  class Configuration
    attr_accessor :history_file, :version_file, :version_constant, :tag_format, :logger

    def initialize
      @logger = unformatter_logger
      @history_file = "history.rdoc"
      @tag_format = "v%s"
      @version_file = "lib/version.rb"
      @version_constant = "VERSION"
    end

    private

    def unformatter_logger
      logger = Logger.new STDOUT
      logger.formatter = log_formatter
      logger
    end

    def log_formatter
      proc {|_severity, _datetime, _progname, msg|
        msg + "\n"
      }
    end
  end
end
