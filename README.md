<div align="left">

[![1g4-linux](https://raw.githubusercontent.com/jopamo/bp/master/.github/bp.png)](#readme)

[![Commits](https://img.shields.io/github/commit-activity/m/jopamo/bp?label=commits&style=for-the-badge)](https://github.com/jopamo/bp/commits)
[![Last Commit](https://img.shields.io/github/last-commit/jopamo/bp/main?label=&style=for-the-badge)](https://github.com/jopamo/bp/commits)

</div>

bp is short for 'backpack' to denote it being easier to move around on various cloud services or embedded devices. It is an alternate [gentoo](https://github.com/gentoo/gentoo) package repo. It is somewhat compatible with gentoo and gentoo overlays using the [package.provided](https://wiki.gentoo.org/wiki//etc/portage/profile/package.provided) mechanism to provide a compatibility layer. Just chroot or [systemd-nspawn](https://wiki.archlinux.org/title/systemd-nspawn) into [these rootfs tarballs](https://1g4.org/linux/) instead of the official [stage tarballs](https://wiki.gentoo.org/wiki/Stage_tarball).

## Distro Configuration
* A mixture of stable and bleeding edge
* no multilib - the toolchain only supports 64bit
* all libraries are installed to /usr/lib
* /lib /lib64 /bin /sbin are all symlinked into /usr/
* supported arches: amd64 arm64
* supported libc: glibc musl
* openssl or libressl is supported
* ncurses or netbsd-curses is supported
* systemd is supported with glibc and musl on both amd64 and arm64
* A number of GNU projects are bootstrapped from git with this [script](./app-core/ugscripts/files/bin/mktarballs).

## Binary Packages
[1g4-glibc-amd64](https://1g4.org/1g4-glibc-amd64/)\
[1g4-musl-amd64](https://1g4.org/1g4-musl-amd64/)\
[1g4-glibc-arm64](https://1g4.org/1g4-glibc-arm64/)\
[1g4-musl-arm64](https://1g4.org/1g4-musl-arm64/)
