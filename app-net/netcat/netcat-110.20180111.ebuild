# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs flag-o-matic

DESCRIPTION="the network swiss army knife"
HOMEPAGE="http://nc110.sourceforge.net/"
SRC_URI="mirror://sourceforge/nc110/nc${PV}.tar.xz -> ${P}.tar.xz"

LICENSE="netcat"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="ipv6 static"

S=${WORKDIR}/nc110

append-cppflags -DTELNET -DGAPING_SECURITY_HOLE
append-ldflags -Wl,-pie
filter-flags -fpic

src_configure() {
	use ipv6 || sed -i '/#define INET6/d' generic.h
}

src_compile() {
	emake \
		LD="$(tc-getCC) ${LDFLAGS}" \
		DFLAGS="${CPPFLAGS}" \
		XFLAGS="${CFLAGS}" \
		STATIC=$(usex static '-static' '') \
		nc
}

src_install() {
	dobin nc
	doman nc.1
	docinto scripts
	dodoc scripts/*
}
