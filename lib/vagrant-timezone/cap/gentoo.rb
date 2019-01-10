require_relative 'linux'

module VagrantPlugins
  module TimeZone
    module Cap
      # Gentoo capabilities for changing time zone
      class Gentoo < Linux
        # Set the time zone if `timedatectl` is not found
        def self.change_timezone_generic(machine, timezone)
          machine.communicate.tap do |comm|
            super

            comm.sudo("echo '#{timezone}' > /etc/timezone")
            comm.sudo('emerge --config timezone-data')
          end
        end
      end
    end
  end
end
