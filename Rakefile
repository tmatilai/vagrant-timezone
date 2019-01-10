# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: ['test:unit', 'style']

desc 'Run all tests'
task test: ['test:unit', 'test:acceptance']

namespace :test do
  desc 'Run unit tests'
  RSpec::Core::RakeTask.new(:unit) do |task|
    task.pattern = 'test/unit/**/*_spec.rb'
  end

  load 'tasks/acceptance.rake'
end

desc 'Run all style checks'
task style: ['style:ruby']

namespace :style do
  desc 'Run style checks for Ruby'
  RuboCop::RakeTask.new(:ruby)
end

# Remove 'install' task as the gem is installed to Vagrant, not to system
Rake::Task[:install].clear
