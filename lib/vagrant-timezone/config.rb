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

        if @value == UNSET_VALUE
          @value = nil
        elsif @value == :host
          # Get the offset of the current timezone of the host. Ruby doesn't reliably
          # detect the named timezone, so we have to use the hour offset. Note that when
          # DST changes, etc, this offset will change.

          # We set timezone offset negative to match POSIX standards
          # https://github.com/eggert/tz/blob/master/etcetera
          @value = format('Etc/GMT%+d', -(Time.now.utc_offset / 3600))
        end
      end
    end
  end
end
