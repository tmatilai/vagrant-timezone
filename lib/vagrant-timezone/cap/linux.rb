require_relative 'unix'

module VagrantPlugins
  module TimeZone
    module Cap
      # Generic Linix capability for changing time zone
      class Linux
        # Set the time zone.
        # Uses `timedatectl` if found.
        def self.change_timezone(machine, timezone)
          if timedatectl?(machine)
            change_timezone_timedatectl(machine, timezone)
          else
            change_timezone_generic(machine, timezone)
          end
        end

        def self.timedatectl?(machine)
          machine.communicate.test('which timedatectl', sudo: true)
        end

        def self.change_timezone_timedatectl(machine, timezone)
          machine.communicate.sudo("timedatectl set-timezone '#{timezone}'")
        end

        # Set the time zone if `timedatectl` is not found.
        # Defaults to `Unix.change_timezone`, but is overridden by distro
        # specific classes.
        def self.change_timezone_generic(machine, timezone)
          Unix.change_timezone(machine, timezone)
        end
      end
    end
  end
end
