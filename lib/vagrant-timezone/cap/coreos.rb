module VagrantPlugins
  module TimeZone
    module Cap
      # CoreOS capabilities for changing time zone
      class CoreOS
        # Set the time zone
        def self.change_timezone(machine, timezone)
          machine.communicate.sudo("timedatectl set-timezone '#{timezone}'")
        end
      end
    end
  end
end
