Generate a 1g4-style ebuild using my repository structure, following these rules:

• Use EAPI=8  
• Use my category layout (for example app-dev, app-build, xgui-lib, etc)  
• No Gentoo legacy dirs or categories  
• Versioning must follow my format: either YYYYMMDD, YYYY.MM.DD, or upstream snapshot hashes  
• No single-line comments may end with a period  
• Do not number code comments  
• Modern Linux-only, no BSD, no Solaris, no prefix support  
• Dependencies must use my category tree (for example app-build/bison instead of sys-devel/bison)  
• Use my variable conventions (SNAPSHOT, S, SRC_URI)  
• Live ebuilds must be 9999 and use git-r3  
• Must inherit the correct eclasses only (autotools, cmake, meson, cargo, python, etc)  
• Do not add FEATURES, RESTRICT, or unnecessary blocks unless required  
• The ebuild must be minimal, clean, and match 1g4 Linux style exactly  
• Only output the final ebuild, nothing else

Example style to mimic:

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="https://stedolan.github.io/jq/"
SNAPSHOT=33b3a68f9c32413cf3a1afa76addf0dd64c2922b
SRC_URI="https://github.com/jqlang/jq/archive/${SNAPSHOT}.tar.gz -> jq-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jq-${SNAPSHOT}"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

DEPEND="
	app-build/bison
	app-build/flex
"
---

# 🗂️ CATEGORY-BY-CATEGORY DESCRIPTION

Each section explains **what belongs there**, **the themes**, and **notable patterns**.

---

# 🔧 **app-build/**

**Purpose:**
Build systems, toolchains, compilers, debuggers, and utilities used to build other software.

**Contents include:**

* **Compilers:** gcc, llvm/clang, binutils, gdb
* **Build systems:** make, ninja, meson, cmake, autotools, gnulib
* **Toolchain helpers:** autoconf, automake, libtool, pkgconf
* **Debugging tools:** gdb, lldb (via llvm), dwarves
* **Support libs for building:** spirv-related tools, gnulib, gnuconfig

**Unifying rule:**
Anything required for building packages (but not end-user development libraries) lives here.

---

# 🛠️ **app-core/**

**Purpose:**
Core system utilities — essential Unix tools and services.

**Contents include:**

* **Shell / terminals:** bash, tmux, screen
* **Filesystem tools:** coreutils, findutils, diffutils, sed, gawk
* **System basics:** dbus, pciutils, kmod, util-linux, procps
* **Systemd & tools:** systemd, systemd-tools
* **Admin utilities:** sudo, lsof, attr/acl, shadow
* **AppArmor:** apparmor, apparmor-utils, apparmor-profiles

**Unifying rule:**
If it ships in a base Linux system or is essential to login, boot, or operate — it’s here.

---

# 🔐 **app-crypto/**

**Purpose:**
Cryptography, encryption, certificates, password tools, smartcard utilities.

**Contents include:**

* **Crypto libs:** botan, libgcrypt, nettle, tpm2-tss
* **Tools:** gnupg, hashcat, hcxtools, cryptsetup
* **PKI / TLS:** openssl, certbot, acme-client, p11-kit
* **Smart card libs:** pcsc-lite, ccid, m2crypto

**Unifying rule:**
Cryptography, cert handling, encryption hardware, and password cracking tools.

---

# 🧰 **app-dev/**

**Purpose:**
Developer tools and frameworks used while writing code.

**Contents include:**

* **Compilers/build helpers:** patchelf, pkgconf
* **Debug/audit tools:** valgrind, strace
* **Language-specific tools:** maturin, jq, fmt
* **Low-level libs & SDKs:** spirv-headers, glslang, opencl-headers
* **Build helpers:** ninja, samurai, gperf, cmake, pkgconf
* **Go/Rust/Python dev tools:** checkbashisms, beautysh

**Unifying rule:**
Developer tools **not essential for system boot**, but essential for coding.

---

# 🧩 **app-emu/**

**Purpose:**
Emulators, disassemblers, VM tools, reverse-engineering aids.

**Contents include:**

* QEMU + qemu-user-static
* capstone, unicorn, keystone
* radare2
* sleuthkit
* acpica

**Unifying rule:**
Tools used for emulation, virtualization, firmware, reversing, and analysis.

---

# 💾 **app-fs/**

**Purpose:**
Filesystem utilities, disk tools, filesystems, data recovery.

**Contents include:**

* e2fsprogs, xfsprogs, ntfs3g, btrfs-progs
* fuse, sshfs
* parted, mdadm, efibootmgr
* cryptsetup, udftools
* smartmontools, testdisk

**Unifying rule:**
Everything related to disks, partitions, filesystems, and recovery tools.

---

# 🐧 **app-kernel/**

**Purpose:**
Kernel, firmware, and low-level system init components.

**Contents include:**

* stable-sources, linux-headers
* linux-firmware
* dracut
* kernel-hardening-checker
* r8125 (kernel network drivers)
* intel-ucode

**Unifying rule:**
Kernel, kernel build dependencies, initramfs, firmware.

---

# 🌐 **app-net/**

**Purpose:**
Networking tools, servers, clients, Wi-Fi, firewalling, packet tools.

**Contents include:**

* openssh, openvpn, wireguard-tools
* curl, wget, rsync, nmap, tcpdump
* iproute2, ethtool, dhcpcd
* bind-tools, dnsmasq, unbound
* networking daemons: realmd/adcli, chrony
* pentest/network tools: hping, aircrack-ng

**Unifying rule:**
Anything networking: diagnostics, daemons, packet capture, tunneling, Wi-Fi.

---

# 📦 **app-port/**

**Purpose:**
Portage-related tools and package-management helpers.

**Contents include:**

* gentoolkit, eix
* pkgdev, repoman, pkgcheck
* elt-patches
* genup, smart-live-rebuild

**Unifying rule:**
Tools for managing Portage and ebuild workflows.

---

# 🧹 **app-util/**

**Purpose:**
General-purpose utilities that aren’t core system tools.

**Contents include:**

* conky, man-db
* numactl, lshw, sysbench
* bc, pv, parallel
* logrotate, hdparm
* usbutils

**Unifying rule:**
Userland utilities and system maintenance tools.

---

# 🗄️ **app-var/**

**Purpose:**
Various tools that don’t belong to other categories.

**Contents include:**

* sysstat
* symlinks
* perl-cleaner
* ansible
* push, quoter

**Unifying rule:**
Tools that are not core, not dev, not net — but general scripts or utilities.

---

# 🖥️ **xgui-lib/**

**Purpose:**
Libraries for the graphical stack: X11, Wayland, GTK, Qt, Pango, Pixman, etc.

**Contents include:**

* X11 libs: libX11, libICE, libSM, libXrandr, xcb-util
* GTK, GTK3, GTK4, GtkSourceView
* Qt5 and Qt6 components: qtbase, qtwayland, qtsvg, qtmultimedia
* Wayland libs + protocols
* Rendering libs: cairo, pixman, freetype
* LXQt stack: libfm-qt, lxqt-session
* Audio/Video libs: libvdpau, libva
* Misc libs: pango, harfbuzz

**Unifying rule:**
All GUI-related libraries but **not applications**.

---

# 🖼️ **xgui-misc/**

**Purpose:**
Miscellaneous GUI components & protocols not fitting lib/app categories.

**Packages include:**

* X keyboard config
* pipewire/pulseaudio/wireplumber (you grouped these as GUI-misc)
* sway (tiling compositor)
* shared-mime-info

**Unifying rule:**
User GUI/session/runtime components that are neither pure libs nor full applications.

---

# 🖥️ **xgui-app/**

**Purpose:**
GUI applications and user-facing graphical programs.

**Contents include:**

* mpv, qbittorrent, pcmanfm-qt, ffmpeg tools
* swaybg, swayidle, swaylock
* flameshot, phototonic, imagemagick tools
* terminal emulators (alacritty, 1term)
* browsers (ladybird)
* codecs: ffmpeg-normalize, pillow, lximage-qt

**Unifying rule:**
Graphical applications launched by users directly.

---

# 🖼️ **xgui-desktop/**

**Purpose:**
Desktop environments, window managers, panels, themes.

**Contents include:**

* i3wm, openbox, fluxbox, fvwm3, jwm
* lxqt-panel
* polybar
* labwc (Wayland compositor)
* hsetroot

**Unifying rule:**
Window managers and desktop shells.

---

# 🎨 **xgui-icontheme/**

**Purpose:**
Icon themes, Qt themes, system-wide icon sets.

**Contents include:**

* Papirus
* Adwaita, Adwaita-qt, Adwaita-plus
* Dracula theme
* LXQt themes
* hicolor-icon-theme

**Unifying rule:**
Icon packs and theme resources.

---

# 🧵 **xmedia-lib/**

**Purpose:**
Media encoding/decoding libraries.

**Contents include:**

* libdav1d, libvpx, x264, x265
* libpng, libjpeg-turbo, libwebp
* libsamplerate, fdk-aac, opus
* shaderc, libplacebo
* audio/video processing libs

**Unifying rule:**
Codec, pixel-format, multimedia processing libraries.

---

# 🎬 **xmedia-app/**

**Purpose:**
Multimedia tools and applications.

**Contents include:**

* V4L utils, mpv, mediainfo
* flameshot, pngquant, exif
* audacious, audacious-plugins
* pavucontrol-qt

**Unifying rule:**
User-facing multimedia utilities or tools.

---

# 🔌 **lib-core/**

**Purpose:**
Core system libraries required by many packages.

**Contents include:**

* glibc, musl, libxcrypt, libseccomp
* ncurses, readline
* zlib, libelf, elfutils
* pam, libapparmor
* openssl or TLS libs may be here if essential

**Unifying rule:**
Foundational libraries essential for booting and running the OS.

---

# 🧱 **lib-dev/**

**Purpose:**
General development libraries not tied to GUI or media.

**Contents include:**

* libusb, libevent, libbsd
* boost, json-c, jsoncpp
* eigen, lapack
* protobuf
* uthash, libyaml
* gobject-introspection, dbus-glib
* tree-sitter / tree-sitter-bash

**Unifying rule:**
Non-GUI, non-media libraries for developers.

---

# 📦 **lib-net/**

**Purpose:**
Networking libraries, protocol implementations.

**Contents include:**

* libbpf, libpcap
* gnutls
* libssh, libgit2
* libnl, libnftnl
* c-ares
* userspace-rcu

**Unifying rule:**
Libraries for network communication, cryptographic protocols, packet capture, wireless.

---

# 🖨️ **lib-print/**

**Purpose:**
Printing stack libraries.

**Contents include:**

* libcupsfilters
* cups-filter, libcups
* libppd

**Unifying rule:**
CUPS-related printing infrastructure.

---

# 🧹 **lib-util/**

**Purpose:**
Utility libraries not fitting core/dev/net/media categories.

**Contents include:**

* glib
* libevdev, libinput
* libsodium
* libev, libb2

**Unifying rule:**
General-purpose system libraries.

---

# 🧩 **lib-misc/**

**Purpose:**
Miscellaneous libraries that have no strict thematic home.

**Contents include:**

* libssh2
* gumbo-parser
* czmq, libzmq, cppzmq
* http-parser
* inih
* libiscsi

**Unifying rule:**
Uncategorized but useful libraries: protocol, parsers, messaging, etc.

---

# 🐍 dev-py/**

**Purpose:**
Python modules and Python build helpers.

**Contents include:**
in tree python ebuilds

**Unifying rule:**
All Python packages installed via Portage (not pip).

---

# 🐍 dev-python/**

**Purpose:**
Python modules and Python build helpers.

**Contents include:**
these are copied directly from gentoo automatically

**Unifying rule:**
All Python packages installed via Portage (not pip).

---

# 🗣️ **app-lang/**

**Purpose:**
Programming languages and runtimes.

**Contents include:**

* python (multiple versions)
* rust (many versions)
* ruby
* go
* php
* lua + luajit
* perl
* tcl, tk
* swig
* nasm, yasm

**Unifying rule:**
Language runtimes, compilers, and FFI tools.

---

# 💬 core-perl/**

Perl core modules your system packages separately.

---

# 📚 fonts/**

Font families and font configuration tools.

---

# 📦 virtual/**

Virtual packages providing ABI/feature providers (your mapping mechanism).

---

# 🔧 bin/**

Binary-only proprietary or large upstream packages.

Includes:

* chrome, firefox-nightly-bin, brave-nightly-bin
* nvidia drivers, rust-bin
* teamviewer, discord
* libreoffice-bin
* android SDK pieces

**Unifying rule:**
Precompiled upstream software.
