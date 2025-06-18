# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Merge this to pull in all Plasma 6 packages"
HOMEPAGE="https://1g4.org/"

LICENSE="metapackage"
SLOT="6"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-build/gdb
	app-build/llvm
	app-core/tmux
	app-crypto/certbot
	app-crypto/pass
	app-crypto/tpm2-tools
	app-dev/beautysh
	app-dev/debootstrap
	app-dev/dwarves
	app-dev/expect
	app-dev/gcovr
	app-dev/intltool
	app-dev/jq
	app-dev/ropgadget
	app-emu/qemu
	app-emu/radare2
	app-fs/btrfs-progs
	app-fs/cryptsetup
	app-fs/dosfstools
	app-fs/e2fsprogs
	app-fs/grub
	app-fs/os-prober
	app-fs/smartmontools
	app-fs/sshfs
	app-fs/testdisk
	app-kernel/dracut
	app-kernel/kernel-hardening-checker
	app-net/bind-tools
	app-net/ethtool
	app-net/hping
	app-net/iftop
	app-net/iperf
	app-net/iputils
	app-net/iw
	app-net/nftables
	app-net/nmap
	app-net/socat
	app-net/tcpdump
	app-port/pkgdev
	app-port/smart-live-rebuild
	app-server/lighttpd
	app-server/nodejs
	app-util/lm-sensors
	app-util/lshw
	app-var/hdparm
	app-var/perl-cleaner
	app-var/sudo
	dev-python/beautifulsoup4
	dev-python/black
	dev-python/paramiko
	dev-python/pip
	dev-python/requests
	virtual/rust
"
