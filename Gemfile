# frozen_string_literal: true

source 'https://rubygems.org'

gem 'vagrant',
    git: 'https://github.com/hashicorp/vagrant.git',
    tag: ENV.fetch('VAGRANT_VERSION', 'v2.2.2')

gem 'rake'
gem 'rspec', '~> 3.1'
gem 'rubocop', '~> 0.62'

group :development do
  gem 'guard-rspec', '~> 4.7'
  gem 'guard-rubocop', '~> 1.3'
end

group :plugins do
  gemspec
end
