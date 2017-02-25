source 'https://rubygems.org'

gem 'vagrant',
  git: 'https://github.com/mitchellh/vagrant.git',
  tag: ENV.fetch('VAGRANT_VERSION', 'v1.9.1')

gem 'rake'
gem 'rspec', '~> 3.1'

group :plugins do
  gem 'vagrant-timezone', path: '.'
end
