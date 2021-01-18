# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

SNAPSHOT=808d93c0eca49e0b22056e23d965f0d967433fbb
SRC_URI="https://git.busybox.net/busybox/snapshot/${PN}-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test strip"

BDEPEND="
	lib-sys/musl
	sys-kernel/sabotage-headers"

append-flags -ffat-lto-objects

src_prepare() {
	default
	cp "${FILESDIR}"/busybox-config "${S}"/.config
	make silentoldconfig
}

src_compile() {
	make CC=musl-gcc
}

src_install() {
	dobin busybox
	dosym busybox usr/bin/sha3sum
	dosym busybox usr/bin/whois
	dosym busybox usr/bin/which
}
