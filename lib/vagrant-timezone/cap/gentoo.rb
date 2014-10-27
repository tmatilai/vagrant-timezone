module VagrantPlugins
  module TimeZone
    module Cap
      # Gentoo capabilities for changing time zone
      class Gentoo
        # Set the time zone
        def self.change_timezone(machine, timezone)
          machine.communicate.tap do |comm|
            if comm.test('which timedatectl', sudo: true)
              comm.sudo("timedatectl set-timezone '#{timezone}'")
            else
              comm.sudo("echo '#{timezone}' > /etc/timezone")
              comm.sudo('emerge --config timezone-data')
            end
          end
        end
      end
    end
  end
end
