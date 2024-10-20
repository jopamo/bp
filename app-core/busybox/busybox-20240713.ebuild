# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

SNAPSHOT=371fe9f71d445d18be28c82a2a6d82115c8af19d
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
		"[" "arping" "awk" "base64" "basename" "bc" "bunzip2" "bzcat" "bzip2"
		"cat" "chgrp" "chmod" "chown" "chroot" "cksum" "clear" "cmp" "comm"
		"cp" "cpio" "cut" "date" "dc" "dd" "df" "diff" "dirname" "dmesg" "du"
		"echo" "ed" "egrep" "eject" "env" "expand" "expr" "factor" "fallocate"
		"false" "fgrep" "find" "flock" "fold" "free" "fuser" "getfattr"
		"getopt" "grep" "groups" "gunzip" "gzip" "head" "hexdump" "hostid"
		"hostname" "id" "install" "ionice" "ipcrm" "ipcs" "kill" "killall"
		"less" "link" "linux32" "linux64" "ln" "logger" "login" "ls" "lsusb"
		"lzcat" "lzma" "md5sum" "mesg" "mkdir" "mkfifo" "mknod" "mktemp"
		"mount" "mountpoint" "mv" "nice" "nl" "nohup" "nproc" "od" "passwd"
		"paste" "pgrep" "pidof" "ping" "pkill" "pmap" "printenv" "printf" "ps"
		"pstree" "pwd" "pwdx" "readlink" "realpath" "renice" "reset" "rev"
		"rm" "rmdir" "run-parts" "sed" "seq" "setpriv" "setsid" "sh" "sha1sum"
		"sha256sum" "sha512sum" "shred" "shuf" "sleep" "sort" "split" "stat"
		"strings" "stty" "su" "sum" "sync" "tac" "tail" "tar" "tee" "test"
		"timeout" "top" "touch" "tr" "true" "truncate" "tsort" "tty" "umount"
		"uname" "unexpand" "uniq" "unlink" "unlzma" "unxz" "unzip" "uptime"
		"watch" "wc" "wget"	"which" "whoami" "xargs" "xxd" "xzcat" "yes" "zcat"
	)

	if ! use minimal; then
		for file in "${files_to_remove[@]}"; do
			if [[ -e "${ED}/usr/bin/${file}" ]]; then
				rm "${ED}/usr/bin/${file}" || die
			fi
		done
	fi
}
