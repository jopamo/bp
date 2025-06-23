<div align="left">

[![1g4-linux](https://raw.githubusercontent.com/jopamo/bp/master/.github/bp.png)](#readme)

[![Commits](https://img.shields.io/github/commit-activity/m/jopamo/bp?label=commits&style=for-the-badge)](https://github.com/jopamo/bp/commits)
[![Last Commit](https://img.shields.io/github/last-commit/jopamo/bp/main?label=&style=for-the-badge)](https://github.com/jopamo/bp/commits)

</div>

bp is short for 'backpack' to denote it being easier to move around on various cloud services or embedded devices. It is an alternate [gentoo](https://github.com/gentoo/gentoo) package repo. It is compatible with gentoo and gentoo overlays using the [package.provided](https://wiki.gentoo.org/wiki//etc/portage/profile/package.provided) mechanism to provide a compatibility layer. Just chroot or [systemd-nspawn](https://wiki.archlinux.org/title/systemd-nspawn) into [these rootfs tarballs](https://1g4.org/) instead of the official [stage tarballs](https://wiki.gentoo.org/wiki/Stage_tarball).

## Features
* supported arches: amd64 arm64
* supported libc: glibc musl
* supported ssl: openssl libressl
* supported curses: ncurses netbsd-curses
* bootstrap golang toolchain from source

## Binary Packages

### core

* [1g4-glibc-amd64](https://1g4.org/1g4-glibc-amd64/)
* [1g4-musl-amd64](https://1g4.org/1g4-musl-amd64/)
* [1g4-glibc-arm64](https://1g4.org/1g4-glibc-arm64/)
* [1g4-musl-arm64](https://1g4.org/1g4-musl-arm64/)

### desktop

* [glibc amd64 desktop](https://1g4.org/1g4-glibc-amd64-desktop/)
* [glibc arm64 desktop](https://1g4.org/1g4-glibc-arm64-desktop/)

## **Category Descriptions**

* **app-build**: Toolchain/build-system packages (compilers, binutils, make, autoconf, etc.), with extensive patch directories per version.
* **app-core**: Essential core utilities and system tools (coreutils, busybox, dbus, systemd, shell tools, init, base userspace).
* **app-compression**: Archive and compression utilities (tar, zip, lz4, bzip2, etc.).
* **app-crypto**: Cryptography libraries, tools, and utilities.
* **app-dev**: Developer tools, build helpers, linting, CI/CD utilities.
* **app-emu**: Emulation and reverse engineering tools (qemu, radare2, binwalk, etc.).
* **app-fs**: Filesystem utilities (btrfs, cryptsetup, lvm, etc.).
* **app-kernel**: Kernel sources, modules, firmware, headers, and kernel-related utilities.
* **app-lang**: Language runtimes/interpreters (python, rust, perl, lua, go, etc.).
* **app-net**: Networking tools, clients, daemons, firewalls, etc.
* **app-port**: Portage, overlays, package management tools.
* **app-server**: Server daemons and infrastructure (nginx, samba, postgresql, etc.).
* **app-tex**: TeX and documentation tools (asciidoc, docbook, sgml, ghostscript, etc.).
* **app-util**: General utility and hardware tools.
* **app-var**: Variable/host-level system utilities (logrotate, sysstat, sudo, etc.).
* **bin**: Prebuilt/proprietary software, package bin stubs (chromium, nvidia, plex, etc.).
* **core-perl**: Core Perl modules.
* **dev-python**/**dev-py**: Python libraries (mirrors Gentoo’s python ecosystem layout).
* **dev-rust**: Rust-specific dev tools (cargo, codeql, etc.).
* **fonts**: Various font families and configs.
* **lib-core**: Low-level C libraries (glibc, musl, zlib, gmp, expat, etc.).
* **lib-dev**: Developer/utility C/C++ libraries (icu, boost, fribidi, jemalloc, etc.).
* **lib-misc**: Miscellaneous libraries.
* **lib-net**: Networking libraries (libpcap, gnutls, openssl, etc.).
* **lib-print**: Printing libraries and tools (cups, libcupsfilters, etc.).
* **lib-util**: System/utility C libraries (glib, libsodium, etc.).
* **licenses**: License texts for packages.
* **metadata**: Portage overlay metadata (layout.conf, md5-cache, etc.).
* **profiles**: Portage profiles for system configuration, targets, and arches.
* **virtual**: Provides virtual packages for dependency abstraction.
* **xgui-app**, **xgui-desktop**, **xgui-icontheme**, **xgui-lib**, **xgui-misc**, **xgui-tools**: X11/Wayland and GUI apps, libraries, icon themes, utilities.
* **xmedia-app**, **xmedia-lib**: Media (audio, video, graphics) apps and libraries.

---

## **General Patterns**

* **Each package** (e.g., `app-core/bash`) contains:

  * A `Manifest` file
  * One or more `.ebuild` files (Gentoo-style build scripts)
  * (Optionally) a `files/` directory for patches, configs, or supporting scripts
* **Eclass directory**: Custom Gentoo eclasses (shared build logic).
* **All profiles/metadata**: For full Portage compatibility and custom configuration.

---

## **Summary Table**

| Category        | Contents/Focus                            |
| --------------- | ----------------------------------------- |
| app-build       | Toolchain & build utils                   |
| app-core        | Core system utilities & base userspace    |
| app-crypto      | Cryptography libs/tools                   |
| app-fs          | Filesystem tools                          |
| app-kernel      | Kernel, headers, modules, firmware        |
| app-lang        | Interpreters, compilers                   |
| app-net         | Networking daemons/utilities              |
| app-server      | Server software                           |
| app-dev         | Developer & build tools                   |
| app-compression | Compression & archive tools               |
| app-emu         | Emulation, reverse engineering            |
| app-util        | Hardware, system utilities                |
| app-var         | Host/variable-level sysutils              |
| bin             | Proprietary/prebuilt/third-party apps     |
| core-perl       | Core Perl modules                         |
| dev-python      | Python packages                           |
| dev-rust        | Rust dev tools                            |
| fonts           | Fonts, font configs                       |
| lib-core        | Essential C libraries                     |
| lib-dev         | C/C++ dev/support libraries               |
| lib-misc        | Misc libraries                            |
| lib-net         | Networking libraries                      |
| lib-print       | Printing libs/tools                       |
| lib-util        | Misc/system C libraries                   |
| licenses        | License texts                             |
| metadata        | Overlay/Portage metadata                  |
| profiles        | Gentoo profiles, arches, targets          |
| virtual         | Virtual packages                          |
| xgui-\*         | GUI/X11/Wayland apps, libs, themes, tools |
| xmedia-\*       | Media-related apps and libs               |
| eclass          | Custom Gentoo eclass scripts              |
