# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A ping-like TCP/IP packet assembler/analyzer"
HOMEPAGE="http://www.hping.org"

SNAPSHOT="3547c7691742c6eaa31f8402e0ccbb81387c1b99"
SRC_URI="https://github.com/antirez/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+tcl"

DEPEND="lib-net/libpcap"

PATCHES=(
	"${FILESDIR}"/${PN}-3_pre20051105-libtcl.patch
	"${FILESDIR}"/${PN}-3_pre20051105-tcl.patch
	"${FILESDIR}"/${PN}-3_pre20051105-tclsh-proper-escaping.patch
	"${FILESDIR}"/${PN}-3_pre20141226-compile.patch
	"${FILESDIR}"/${PN}-3_pre20141226-hping2-2-hping.patch
	"${FILESDIR}"/${PN}-3_pre20141226-indent.patch
	"${FILESDIR}"/${PN}-3_pre20141226-pcap-bpf.patch
	"${FILESDIR}"/${PN}-3_pre20141226-scan-overflow.patch
	"${FILESDIR}"/${PN}-3_pre20141226-unused-but-set.patch
	"${FILESDIR}"/${PN}-3_pre20141226-fno-common.patch
)

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
