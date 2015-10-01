source 'https://rubygems.org'

gem 'vagrant',
  git: 'https://github.com/mitchellh/vagrant.git',
  ref: ENV.fetch('VAGRANT_VERSION', 'v1.7.4')

gem 'rake'
gem 'rspec', '~> 3.1'

group :plugins do
  gem 'vagrant-timezone', path: '.'
end
