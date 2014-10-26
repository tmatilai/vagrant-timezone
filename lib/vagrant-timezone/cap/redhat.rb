module VagrantPlugins
  module TimeZone
    module Cap
      # RedHat capabilities for changing time zone
      class RedHat
        # Set the time zone
        def self.change_timezone(machine, timezone)
          machine.communicate.tap do |comm|
            comm.sudo("echo 'ZONE=\"#{timezone}\"' > /etc/sysconfig/clock")
            comm.sudo("ln -sf /usr/share/zoneinfo/#{timezone} /etc/localtime")
          end
        end
      end
    end
  end
end
