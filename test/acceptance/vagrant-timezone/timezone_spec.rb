# frozen_string_literal: true

shared_examples 'provider/timezone' do |provider, options|
  if !options[:box_path]
    raise ArgumentError,
          "'box_path' option must be specified for provider: #{provider}"
  end

  include_context 'acceptance'

  if provider.to_s == 'virtualbox'
    let(:extra_env) do
      # Special magic for VirtualBox
      { 'VBOX_USER_HOME' => '{{homedir}}' }
    end
  end

  before do
    environment.skeleton('timezone')
    environment.env['VAGRANT_SPEC_TIMEZONE'] = timezone

    assert_execute('vagrant', 'box', 'add', 'box', options[:box_path])
  end

  after do
    execute('vagrant', 'destroy', '--force')
  end

  context 'when starting' do
    context 'without configuration' do
      let(:timezone) { nil }

      it 'does not configure the time zone' do
        result = assert_execute('vagrant', 'up', "--provider=#{provider}")
        expect(result.stdout).not_to match(/Setting time zone/)
      end
    end

    context 'with a time zone name' do
      # Something without DST so that the offset is always known
      let(:timezone) { 'America/Argentina/Buenos_Aires' }

      it 'configures the specified time zone' do
        result = assert_execute('vagrant', 'up', "--provider=#{provider}")
        expect(result.stdout).to match(/Setting time zone to '#{timezone}'/)

        result = assert_execute('vagrant', 'ssh', '-c', 'date "+TZ: %z"')
        expect(result.stdout).to match(/^TZ: -0300$/)
      end
    end
  end

  context 'when reloading' do
    context 'with :host' do
      # First configure to something else than the host
      let(:timezone) do
        offset = host_offset[0, 3].to_i
        offset = 10 if offset.zero?
        # Negate the host offset!
        # https://github.com/eggert/tz/blob/master/etcetera
        Kernel.format('Etc/GMT%+d', offset)
      end

      let(:host_offset) { `date "+%z"`.chomp }

      it 'configures the same time zone than on the host' do
        status('First start the machine with other timezone')
        assert_execute('vagrant', 'up', "--provider=#{provider}")

        # Change the configuration in Vagrantfile
        environment.env['VAGRANT_SPEC_TIMEZONE'] = ':host'

        status('Reloading with :host')
        result = assert_execute('vagrant', 'reload')
        expect(result.stdout).to match(%r{Setting time zone to 'Etc/GMT})

        result = assert_execute('vagrant', 'ssh', '-c', 'date "+TZ: %z"')
        expect(result.stdout).to match(/^TZ: #{Regexp.escape(host_offset)}$/)
      end
    end
  end
end
