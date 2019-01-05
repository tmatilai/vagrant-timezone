require_relative '../logger'

module VagrantPlugins
  module TimeZone
    module Action
      # Vagrant middleware action that sets the specified time zone
      class SetTimeZone
        def initialize(app, _env)
          @app = app
        end

        def call(env) # rubocop:disable Metrics/AbcSize
          @app.call(env)

          machine = env[:machine]
          timezone = machine.config.timezone.value

          if timezone.nil?
            logger.info I18n.t('vagrant_timezone.not_enabled')
          elsif machine.guest.capability?(:change_timezone)
            env[:ui].info I18n.t('vagrant_timezone.configuring')
            machine.guest.capability(:change_timezone, timezone)
          else
            logger.info I18n.t('vagrant_timezone.not_supported')
          end
        end

        # @return [Log4r::Logger]
        def logger
          TimeZone.logger
        end
      end
    end
  end
end
