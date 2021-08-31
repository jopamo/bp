# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

SNAPSHOT=a51d953b95a7cc6b40a6b3a5bfd95f3154acf5e2
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
	if has_version \>=lib-core/glibc-2.33.0 ; then
		append-ldflags -static
	fi

	emake CC=musl-gcc
}

src_install() {
	dobin busybox
	dosym busybox usr/bin/sha3sum
	dosym busybox usr/bin/whois
}
