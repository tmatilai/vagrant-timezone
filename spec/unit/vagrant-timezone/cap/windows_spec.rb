require 'spec_helper'
require 'vagrant-timezone/cap/windows'

describe VagrantPlugins::TimeZone::Cap::Windows do
    subject { described_class }

    describe "#get_timezone_from_offset" do
        it 'takes string and returns timezone' do
            [
                ["-10", "Hawaiian Standard Time"],
                ["+10", "E. Australia Standard Time"]
            ].each do |shift, expected|
                offset = subject.get_timezone_from_offset("Etc/GMT#{shift}")
                expect(offset).to eq(expected)
            end
        end
    end
end