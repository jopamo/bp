# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A ping-like TCP/IP packet assembler/analyzer"
HOMEPAGE="http://www.hping.org"
SNAPSHOT=4a444edd6d883f62869f6afe977d36b427b51bc2
SRC_URI="https://github.com/jopamo/hping/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="tcl"

DEPEND="lib-net/libpcap"

src_configure() {
	tc-export CC

	sh configure $(usex tcl '' --no-tcl) || die
}

src_compile() {
	emake \
		DEBUG="" \
		"CFLAGS=${CFLAGS}" \
		"AR=$(tc-getAR)" \
		"RANLIB=$(tc-getRANLIB)" \
		"LIBDIR=lib"
}

src_install() {
	dobin hping3
	dosym -r /usr/bin/hping3 /usr/bin/hping
	dosym -r /usr/bin/hping3 /usr/bin/hping2

	newman docs/hping3.8 hping.8
}
