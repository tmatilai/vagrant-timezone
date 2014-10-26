require 'log4r'

module VagrantPlugins
  # Base module for Vagrant TimeZone plugin
  module TimeZone
    # @return [Log4r::Logger] the logger instance for this plugin
    def self.logger
      @logger ||= Log4r::Logger.new('vagrant::timezone')
    end
  end
end
