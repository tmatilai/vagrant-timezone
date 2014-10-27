require 'vagrant'
require_relative 'logger'

module VagrantPlugins
  module TimeZone
    # Vagrant Plugin class that registers configs, hooks, etc.
    #
    # @!parse class Plugin < Vagrant::Plugin::V2::Plugin; end
    class Plugin < Vagrant.plugin('2')
      # Compatible Vagrant versions
      VAGRANT_VERSION_REQUIREMENT = '>= 1.2.0'

      # Returns true if the Vagrant version fulfills the requirements
      #
      # @param requirements [String, Array<String>] the version requirement
      # @return [Boolean]
      def self.check_vagrant_version(*requirements)
        Gem::Requirement.new(*requirements).satisfied_by?(
          Gem::Version.new(Vagrant::VERSION))
      end

      # Verifies that the Vagrant version fulfills the requirements
      #
      # @raise [VagrantPlugins::TimeZone::VagrantVersionError] if this plugin
      # is incompatible with the Vagrant version
      def self.check_vagrant_version!
        if !check_vagrant_version(VAGRANT_VERSION_REQUIREMENT)
          msg = I18n.t(
            'vagrant_timezone.errors.vagrant_version',
            requirement: VAGRANT_VERSION_REQUIREMENT.inspect)
          $stderr.puts msg
          raise msg
        end
      end

      # Initializes the internationalization strings
      def self.setup_i18n
        I18n.load_path << File.expand_path('../../../locales/en.yml', __FILE__)
        I18n.reload!
      end

      setup_i18n
      check_vagrant_version!

      name 'vagrant-timezone'

      config 'timezone' do
        require_relative 'config'
        Config
      end

      action_hook 'timezone_configure', :machine_action_up do |hook|
        require_relative 'action/set_timezone'
        hook.after Vagrant::Action::Builtin::Provision, Action::SetTimeZone
      end

      action_hook 'timezone_configure', :machine_action_reload do |hook|
        require_relative 'action/set_timezone'
        hook.after Vagrant::Action::Builtin::Provision, Action::SetTimeZone
      end

      guest_capability 'arch', 'change_timezone' do
        require_relative 'cap/arch'
        Cap::Arch
      end

      guest_capability 'coreos', 'change_timezone' do
        require_relative 'cap/coreos'
        Cap::CoreOS
      end

      guest_capability 'darwin', 'change_timezone' do
        require_relative 'cap/unix'
        Cap::Unix
      end

      guest_capability 'debian', 'change_timezone' do
        require_relative 'cap/debian'
        Cap::Debian
      end

      guest_capability 'freebsd', 'change_timezone' do
        require_relative 'cap/unix'
        Cap::Unix
      end

      guest_capability 'gentoo', 'change_timezone' do
        require_relative 'cap/gentoo'
        Cap::Gentoo
      end

      guest_capability 'netbsd', 'change_timezone' do
        require_relative 'cap/unix'
        Cap::Unix
      end

      guest_capability 'openbsd', 'change_timezone' do
        require_relative 'cap/unix'
        Cap::Unix
      end

      guest_capability 'redhat', 'change_timezone' do
        require_relative 'cap/redhat'
        Cap::RedHat
      end
    end
  end
end
