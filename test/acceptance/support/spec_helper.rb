# frozen_string_literal: true

require 'vagrant-spec/acceptance'

# Dirty monkey patch to work around
# https://github.com/hashicorp/vagrant-spec/pull/17
module Vagrant
  module Spec
    class AcceptanceIsolatedEnvironment
      attr_reader :env if !method_defined?(:env)
    end
  end
end

# Disable Vagrant's version checks
ENV['VAGRANT_CHECKPOINT_DISABLE'] = '1'
