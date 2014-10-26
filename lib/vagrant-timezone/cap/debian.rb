module VagrantPlugins
  module TimeZone
    module Cap
      # Debian capabilities for changing time zone
      module Debian
        # Set the time zone
        def self.change_timezone(machine, timezone)
          machine.communicate.tap do |comm|
            comm.sudo("echo '#{timezone}' > /etc/timezone")
            comm.sudo('dpkg-reconfigure --frontend noninteractive tzdata')
          end
        end
      end
    end
  end
end
