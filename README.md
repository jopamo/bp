<div align="left">

[![1g4-linux](https://raw.githubusercontent.com/jopamo/bp/master/.github/bp.png)](#readme)

[![Commits](https://img.shields.io/github/commit-activity/m/jopamo/bp?label=commits&style=for-the-badge)](https://github.com/jopamo/bp/commits)
[![Last Commit](https://img.shields.io/github/last-commit/jopamo/bp/main?label=&style=for-the-badge)](https://github.com/jopamo/bp/commits)

</div>

bp is short for 'backpack' to denote it being easier to move around on various cloud services or embedded devices. It is an alternate [gentoo](https://github.com/gentoo/gentoo) package repo. It is somewhat compatible with gentoo and gentoo overlays, some stuff will work, but most probably will not. It uses the package.provided mechanism to provide a compatibility layer, changing the names of categories allowing the gentoo tree version of certain packages to never be used without fighting for namespaces.

## Distro Configuration
* no multilib - the toolchain only supports 64bit
* all libraries are installed to /usr/lib
* /lib /lib64 /bin /sbin are all symlinked into /usr/
* only amd64 and arm64 are supported
* only glibc or musl are supported
* it supports your choice of openssl or libressl
   * switching back and forth with preserve-libs should work
* it supports your choice of ncurses or netbsd-curses
   * switching from default of ncurses to netbsd-curses works, switching from netbsd-curses to ncurses does not work
* systemd is supported with musl on both amd64 and arm64
* [A number of GNU projects are bootstrapped from git with this script.](./app-core/ugscripts/files/sbin/mktarballs)
