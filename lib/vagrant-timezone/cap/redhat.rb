require_relative 'unix'

module VagrantPlugins
  module TimeZone
    module Cap
      # RedHat capabilities for changing time zone
      class RedHat < Unix
        # Set the time zone
        def self.change_timezone(machine, timezone)
          machine.communicate.tap do |comm|
            if comm.test('which timedatectl', sudo: true)
              comm.sudo("timedatectl set-timezone '#{timezone}'")
            else
              comm.sudo(
                "echo 'ZONE=\"#{timezone}\"' > /etc/sysconfig/clock")
            end
        end
      end
    end
  end
end
