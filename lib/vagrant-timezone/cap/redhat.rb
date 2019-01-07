require_relative 'linux'

module VagrantPlugins
  module TimeZone
    module Cap
      # RedHat capabilities for changing time zone
      class RedHat < Linux
        # Set the time zone if `timedatectl` is not found
        def self.change_timezone_generic(machine, timezone)
          super

          machine.communicate.sudo(
            "echo 'ZONE=\"#{timezone}\"' > /etc/sysconfig/clock"
          )
        end
      end
    end
  end
end
