require_relative 'linux'

module VagrantPlugins
  module TimeZone
    module Cap
      # Debian capabilities for changing time zone
      class Debian < Linux
        # Set the time zone if `timedatectl` is not found
        def self.change_timezone_generic(machine, timezone)
          machine.communicate.tap do |comm|
            comm.sudo("echo '#{timezone}' > /etc/timezone")
            comm.sudo('dpkg-reconfigure --frontend noninteractive tzdata')
          end
        end
      end
    end
  end
end
