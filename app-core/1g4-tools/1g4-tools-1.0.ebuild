# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="1g4 development and administration tools"
HOMEPAGE="https://1g4.org/"

# This package intentionally installs no files.
PROPERTIES="empty-install"

LICENSE="metapackage"
SLOT="6"
KEYWORDS="amd64 arm64"

RDEPEND="
app-lang/go
app-build/gdb
app-build/llvm
app-core/bx
app-core/lsof
app-core/sudo
app-core/tmux
app-crypto/certbot
app-crypto/pass
app-crypto/tpm2-tools
app-dev/beautysh
app-dev/coccinelle
app-dev/ctags
app-dev/debootstrap
app-dev/dwarves
app-dev/gcovr
app-dev/intltool
app-dev/ropgadget
app-dev/strace
app-dev/valgrind
app-emu/qemu
app-emu/radare2
app-fs/btrfs-progs
app-fs/cryptsetup
app-fs/dosfstools
app-fs/e2fsprogs
app-fs/grub
app-fs/mdadm
app-fs/os-prober
app-fs/parted
app-fs/smartmontools
app-fs/sshfs
app-fs/testdisk
app-kernel/dracut
app-kernel/k1g4
app-kernel/kernel-hardening-checker
app-kernel/perf
app-net/aircrack-ng
app-net/bind-tools
app-net/bpftool
app-net/ethtool
app-net/iftop
app-net/iperf
app-net/iputils
app-net/iw
app-net/linuxptp
app-net/nftables
app-net/nmap
app-net/sockperf
app-net/tcpdump
app-net/wpa_supplicant
app-server/lighttpd
app-server/nodejs
app-util/lshw
app-var/perl-cleaner
dev-pypi/black
dev-pypi/httpx
dev-pypi/paramiko
dev-pypi/pexpect
dev-pypi/pip
dev-pypi/pytest
lib-net/xdp-tools
virtual/rust
"
