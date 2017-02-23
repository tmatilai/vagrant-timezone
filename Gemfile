source 'https://rubygems.org'
# Ruby > 2.2.x causes failure to install
# ruby "2.2.6"

gem 'vagrant',
  git: 'https://github.com/mitchellh/vagrant.git',
  tag: ENV.fetch('VAGRANT_VERSION', 'v1.8.1')

gem 'rake'
gem 'rspec', '~> 3.1'

group :plugins do
  gem 'vagrant-timezone', path: '.'
end
