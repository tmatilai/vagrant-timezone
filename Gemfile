source 'https://rubygems.org'

gem 'vagrant',
    git: 'https://github.com/hashicorp/vagrant.git',
    tag: ENV.fetch('VAGRANT_VERSION', 'v2.2.2')

gem 'rake'
gem 'rspec', '~> 3.1'

group :plugins do
  gem 'vagrant-timezone', path: '.'
end
