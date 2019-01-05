require 'spec_helper'
require 'vagrant-timezone/config'

describe VagrantPlugins::TimeZone::Config do
  subject { described_class.new }

  describe '#value' do
    it 'defaults to nil' do
      subject.finalize!
      expect(subject.value).to be(nil)
    end

    it 'can be set' do
      subject.value = 'FOO'
      subject.finalize!
      expect(subject.value).to eq('FOO')
    end

    it 'can be set' do
      subject.value = 'FOO'
      subject.finalize!
      expect(subject.value).to eq('FOO')
    end

    it 'converts `:host` to the zone of the host' do
      allow(Time).to receive(:now).and_return(Time.new(2016, 7, 10, 2, 12, 0, '+03:00'))
      subject.value = :host
      subject.finalize!
      expect(subject.value).to eq('Etc/GMT-3')
    end
  end
end
