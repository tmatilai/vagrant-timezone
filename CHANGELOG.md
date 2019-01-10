# 1.3.0 / 2019-01-10

- Use `timedatectl` on all Linux distributions if found ([GH-10][], [GH-7][], [GH-5][])
    * `systemd` is now used on many Linux distros (e.g. Debian based ones)

- Improve testing by adding acceptance and style tests ([GH-11][])

[GH-5]: https://github.com/tmatilai/vagrant-timezone/issues/5 "Issue 5"
[GH-7]: https://github.com/tmatilai/vagrant-timezone/issues/7 "Issue 7"
[GH-10]: https://github.com/tmatilai/vagrant-timezone/issues/10 "Issue 10"
[GH-11]: https://github.com/tmatilai/vagrant-timezone/issues/11 "Issue 11"

# 1.2.0 / 2017-02-25

Features:

- Support Windows guests ([GH-4][])

[GH-4]: https://github.com/tmatilai/vagrant-timezone/issues/4 "Issue 4"

# 1.1.0 / 2015-10-01

Features:

- Add option (`config.timezone.value = :host`) to synchronize the guest timezone with the host ([GH-2][])

[GH-2]: https://github.com/tmatilai/vagrant-timezone/issues/2 "Issue 2"

# 1.0.0 / 2014-10-27

Features:

- Support Arch, CoreOS, and Gentoo Linux
- Support FreeBSD, NetBSD, and OpenBSD
- Support OS X

# 0.1.0 / 2014-10-26

- Initial release
- Support Debian and RedHat based distros
