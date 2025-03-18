# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

SNAPSHOT=240ee6c774729c9c24812aa8912f1fcf8996b162
SHORT=${SNAPSHOT:0:7}


DESCRIPTION="Transport Independent RPC library (SunRPC replacement)"
HOMEPAGE="http://libtirpc.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/libtirpc/${P}.tar.bz2"

SRC_URI="https://git.linux-nfs.org/?p=steved/libtirpc.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SHORT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-cflags -std=gnu17
	append-ldflags $(test-flags-CCLD -Wl,--undefined-version)
	append-lfs-flags

	local myconf=(
		$(use_enable ipv6)
		$(use_enable static-libs static)
		--disable-gssapi
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
