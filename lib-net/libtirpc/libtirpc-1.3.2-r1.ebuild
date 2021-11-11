# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="Transport Independent RPC library (SunRPC replacement)"
HOMEPAGE="http://libtirpc.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/libtirpc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 static-libs"

DEPEND="
	app-compression/xz-utils
	app-dev/pkgconf
"

PATCHES=( "${FILESDIR}"/86529758570cef4c73fb9b9c4104fdc510f701ed.patch )

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
		--disable-gssapi
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf ${myconf[@]}
}

src_install() {
	default

	insinto /etc
	doins doc/netconfig

	insinto /usr/include/tirpc
	doins -r "${S}"/tirpc/*
}
