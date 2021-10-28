<div align="left">

[![1g4-linux](https://raw.githubusercontent.com/jopamo/bp/master/.github/bp.png)](#readme)

[![Commits](https://img.shields.io/github/commit-activity/m/jopamo/bp?label=commits&style=for-the-badge)](https://github.com/jopamo/bp/commits)
[![Last Commit](https://img.shields.io/github/last-commit/jopamo/bp/master?label=&style=for-the-badge)](https://github.com/jopamo/bp/commits)

</div>

bp is short for 'backpack' to denote it being easier to move around on various cloud services. It is an alternate [gentoo](https://github.com/gentoo/gentoo) package repo. It is yet not compatible with gentoo or gentoo overlays, some stuff will work, but most will not. The plan is to just use the package.provided mechanism to provide a compatibility layer for using the gentoo repo or gentoo overlays. The easiest way to do this is to change the names of categories allowing the gentoo tree version of certain packages to never be used.

Below are some highlights from the configuration
* link time optimization and the Integer Set Library are enabled by default, just set NTHREAD in your make.conf
  * Thank you to [gentooLTO!](https://github.com/InBetweenNames/gentooLTO)
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
* I primarily use systemd, but the -systemd use flag should disable installing every single systemd file.
* systemd is supported with musl on both amd64 and arm64
* link time optimization is enabled globally by default
* security compiler options such as fpie, fpic, D_FORTIFY_SOURCE, fstack-protector-strong, etc are all enabled by default as well
* more on the way...
