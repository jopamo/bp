# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="the network swiss army knife"
HOMEPAGE="http://nc110.sourceforge.net/"
SNAPSHOT=182804d69bde0022d74c27f924ed99b2fe540f3c
SRC_URI="https://github.com/jopamo/netcat/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="netcat"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

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
