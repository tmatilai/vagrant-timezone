module VagrantPlugins
  module TimeZone
    module Cap
      # Generic *nix capabilities for changing time zone
      class Unix
        # Set the time zone
        def self.change_timezone(machine, timezone)
          machine.communicate.sudo(
            "ln -sf /usr/share/zoneinfo/#{timezone} /etc/localtime",
            shell: 'sh'
          )
        end
      end
    end
  end
end
