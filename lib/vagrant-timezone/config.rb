require 'vagrant'

module VagrantPlugins
  module TimeZone
    # Configuration for the Time Zone plugin
    #
    # @!parse class Config < Vagrant::Plugin::V2::Config; end
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :value

      def initialize
        super

        @value = UNSET_VALUE
      end

      def finalize!
        super

        @value = nil if @value == UNSET_VALUE
      end
    end
  end
end
