require 'spec_helper'
require 'vagrant-timezone/cap/windows'

describe VagrantPlugins::TimeZone::Cap::Windows do
  subject { described_class }

  describe '.timezone_name' do
    context 'with Etc/GMT format' do
      it 'returns the timezone name for negative offset' do
        expect(subject.timezone_name('Etc/GMT-10')).to eq 'Hawaiian Standard Time'
      end

      it 'returns the timezone name for positive offset' do
        expect(subject.timezone_name('Etc/GMT+10')).to eq 'E. Australia Standard Time'
      end
    end

    context 'with unknown format' do
      it 'returns the specied timezone unchanged' do
        expect(subject.timezone_name('UTC')).to eq 'UTC'
      end
    end
  end
end
