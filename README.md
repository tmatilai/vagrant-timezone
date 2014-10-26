# Time Zone Configuration Plugin for Vagrant

[![Gem Version](https://badge.fury.io/rb/vagrant-timezone.png)][gem]
[![Build Status](https://travis-ci.org/tmatilai/vagrant-timezone.png?branch=master)][travis]

[gem]: https://rubygems.org/gems/vagrant-timezone
[travis]: https://travis-ci.org/tmatilai/vagrant-timezone

A [Vagrant](http://www.vagrantup.com/) plugin that configures the time zone of a virtual machines.

If you want to use a specific time zone in a Vagrant VM, or if a third party base box comes with a non-standard time zone, this plugin is to the rescue. The configuration is done on `vagrant up` and `vagrant reload` actions. Note that no services are restarted automatically so they may keep using the old time zone information.

## Usage

Install the plugin:

```sh
vagrant plugin install vagrant-timezone
```

To configure time zone for all Vagrant VMs, add the following to _$HOME/.vagrant.d/Vagrantfile_ (or to a project specific _Vagrantfile_):

```ruby
Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "UTC"
  end
  # ... other stuff
end
```

## Compatibility

This plugin requires Vagrant 1.2 or newer ([downloads](https://www.vagrantup.com/downloads)).

The plugin is supposed to be compatible with all Vagrant providers and other plugins. Please file an [issue](https://github.com/tmatilai/vagrant-timezone/issues) if this is not the case.

At the moment only Debian and RedHat based VMs are supported.
