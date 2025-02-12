# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

SNAPSHOT=411543949605fd7e9c996a0a2aadf8b344a4ced0
SRC_URI="https://git.busybox.net/busybox/snapshot/busybox-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minimal"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

src_prepare() {
	filter-flags -fuse-ld=lld

	append-flags -ffat-lto-objects
	append-ldflags -static
	append-ldflags -Wl,-z,noexecstack

	default

	eapply "${FILESDIR}"/*.patch
	cp "${FILESDIR}"/busybox-config "${S}"/.config || die
	make silentoldconfig
}

src_compile() {
	CC=${CC:-gcc}

	if ${CC} --version | grep -q 'clang'; then
		echo "Detected Clang"
		emake CC=musl-clang
	elif ${CC} --version | grep -q 'gcc'; then
		echo "Detected GCC"
		emake CC=musl-gcc
	else
		echo "Unknown compiler"
		exit 1
	fi
}

src_install() {
	dobin busybox
	doman docs/busybox.1

	while read -r applet; do
		dosym -r /usr/bin/busybox "/usr/bin/${applet}"
	done < <("${ED}/usr/bin/busybox" --list)

	local files_to_remove=(
		"[" "arping" "awk" "base64" "basename" "bc" "blkdiscard" "blkid"
		"blockdev" "bunzip2" "bzcat" "bzip2" "cat" "chgrp" "chmod" "chown"
		"chpasswd" "chroot" "cksum" "clear" "cmp" "comm" "cp" "cpio" "cut"
		"date" "dc" "dd" "depmod" "df" "diff" "dirname" "dmesg" "du" "echo"
		"ed" "egrep" "eject" "env" "expand" "expr" "factor" "fallocate"
		"false" "fdisk" "fgrep" "find" "findfs" "flock" "fold" "free" "fuser"
		"getfattr" "getopt" "grep" "groups" "gunzip" "gzip" "halt" "head"
		"hexdump" "hostid" "hostname" "id" "init" "install" "insmod" "ionice"
		"ip" "ipcrm" "ipcs" "kill" "killall" "less" "link" "linux32" "linux64"
		"ln" "logger" "login" "losetup" "ls" "lsmod" "lsusb" "lzcat" "lzma"
		"md5sum" "mesg" "mkdir" "mkfifo" "mknod" "mktemp" "mkswap" "modinfo"
		"modprobe" "mount" "mountpoint" "mv" "nc" "nice" "nl" "nologin"
		"nohup" "nproc" "nslookup" "od" "passwd" "paste" "pgrep" "pidof" "ping" "pkill"
		"pmap" "poweroff" "printenv" "printf" "ps" "pstree" "pwd" "pwdx"
		"readlink" "realpath" "reboot" "renice" "reset" "rev" "rfkill" "rm"
		"rmdir"	"rmmod" "run-parts" "sed" "seq" "setpriv" "setsid" "sh"
		"sha1sum" "sha256sum" "sha512sum" "shred" "shuf" "sleep" "sort" "split"
		"stat" "strings" "stty" "su" "sum" "swapoff" "swapon" "sync" "sysctl"
		"tac" "tail" "tar" "tee" "test" "timeout" "top" "touch" "tr" "true"
		"truncate" "tsort" "tty" "umount" "uname" "unexpand" "uniq" "unlink"
		"unlzma" "unxz" "unzip" "uptime" "vi" "watch" "wc" "wget"
		"which"	"whoami" "xargs" "xxd" "xzcat" "yes" "zcat"
)


	if ! use minimal; then
		for file in "${files_to_remove[@]}"; do
			if [[ -e "${ED}/usr/bin/${file}" ]]; then
				rm "${ED}/usr/bin/${file}" || die
			fi
		done
	fi
}
