# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Meta package installed by default but will auto purge if not kept."
HOMEPAGE="https://1g4.org/"

LICENSE="metapackage"
SLOT="6"
KEYWORDS="amd64 arm64"

RDEPEND="
!elibc_musl? ( app-lang/go )
app-build/gdb
app-build/llvm
app-core/lsof
app-core/sudo
app-core/tmux
app-crypto/certbot
app-crypto/pass
app-crypto/tpm2-tools
app-dev/beautysh
app-dev/debootstrap
app-dev/dwarves
app-dev/gcovr
app-dev/intltool
app-dev/jq
app-dev/ropgadget
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
app-kernel/kernel-hardening-checker
app-net/aircrack-ng
app-net/bind-tools
app-net/dropbear
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
app-net/traceroute
app-port/pkgdev
app-port/smart-live-rebuild
app-server/lighttpd
app-util/lshw
app-var/hdparm
app-var/perl-cleaner
dev-py/beautifulsoup4
dev-python/black
dev-python/httpx
dev-python/paramiko
dev-python/pexpect
dev-python/pip
dev-python/requests
dev-rust/fd
dev-rust/ripgrep
virtual/rust
"
