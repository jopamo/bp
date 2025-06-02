# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Merge this to pull in all Plasma 6 packages"
HOMEPAGE="https://1g4.org/"

LICENSE="metapackage"
SLOT="6"
KEYWORDS="amd64 arm64"

IUSE="gui"

RDEPEND="
	app-core/tmux
	app-crypto/pass
	app-crypto/tpm2-tools
	app-dev/beautysh
	app-dev/expect
	app-dev/jq
	app-emu/qemu
	app-fs/dosfstools
	app-fs/e2fsprogs
	app-fs/os-prober
	app-fs/smartmontools
	app-fs/testdisk
	app-kernel/kernel-hardening-checker
	app-net/bind-tools
	app-net/ethtool
	app-net/hping
	app-net/iperf
	app-net/iputils
	app-net/iw
	app-net/nftables
	app-net/nmap
	app-net/tcpdump
	app-port/pkgdev
	app-util/lm-sensors
	app-util/lshw
	app-var/hdparm
	app-var/perl-cleaner
	app-var/sudo
	virtual/rust
	!elibc_musl? (
		app-lang/go
		)

gui? (
	app-net/weechat
	bin/apktool
	app-util/better-adb-sync
	app-var/usbutils
	bin/brave-nightly-bin
	bin/filebot
	bin/google-chrome-unstable
	bin/nvidia-drivers
	bin/openjdk8
	bin/platform-tools
	bin/signal-desktop-bin
	xmedia-app/imagemagick
	xmedia-app/mediainfo
	xmedia-app/qrencode
		app-kernel/linux-firmware
	app-kernel/stable-sources
	app-fs/grub
)
"
