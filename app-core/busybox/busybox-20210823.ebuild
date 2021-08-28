# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

SNAPSHOT=60f4843468213324cc348af9d8ec09648b6f6784
SRC_URI="https://git.busybox.net/busybox/snapshot/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

append-flags -ffat-lto-objects

src_prepare() {
	default
	cp "${FILESDIR}"/busybox-config-musl "${S}"/.config
	make silentoldconfig
}

src_compile() {
	emake CC=musl-gcc
}

src_install() {
	dobin busybox
	dosym busybox usr/bin/sha3sum
	dosym busybox usr/bin/whois
}
