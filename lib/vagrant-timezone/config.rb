require 'vagrant'

module VagrantPlugins
  module TimeZone
    # Configuration for the Time Zone plugin
    #
    # @!parse class Config < Vagrant::Plugin::V2::Config; end
    class Config < Vagrant.plugin('2', :config)
      attr_reader :value

      def initialize
        super

        @value = UNSET_VALUE
      end

      def value= value
        if value == :host
          # Get the offset of the current timezone of the host. Ruby doesn't reliably
          # detect the named timezone, so we have to use the hour offset. Note that when
          # DST changes, etc, this offset will change.

          # We set timezone offset negative to match POSIX standards
          # https://github.com/eggert/tz/blob/master/etcetera
          @value = sprintf('Etc/GMT%+d', -(Time.now.utc_offset/3600))
        else
          @value = value
        end
      end

      def finalize!
        super

        @value = nil if @value == UNSET_VALUE
      end
    end
  end
end
