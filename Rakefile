# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task default: 'test:unit'

desc 'Run all tests'
task test: ['test:unit']

namespace :test do
  desc 'Run unit tests'
  RSpec::Core::RakeTask.new(:unit) do |task|
    task.pattern = 'test/unit/**/*_spec.rb'
  end
end

# Remove 'install' task as the gem is installed to Vagrant, not to system
Rake::Task[:install].clear
