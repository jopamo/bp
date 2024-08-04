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

RESTRICT="test strip"

BDEPEND="lib-core/musl"

src_prepare() {
	default
	eapply "${FILESDIR}"/*.patch
	cp "${FILESDIR}"/busybox-config "${S}"/.config || die
	make silentoldconfig
}

src_compile() {
	append-flags -ffat-lto-objects
	append-ldflags -static
	append-ldflags -Wl,-z,noexecstack

	emake CC=musl-gcc
}

src_install() {
	dobin busybox
	doman docs/busybox.1
}
