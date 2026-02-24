# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="nl80211-based configuration utility for wireless devices"
HOMEPAGE="https://wireless.kernel.org/en/users/Documentation/iw"
SNAPSHOT=05bc0bb7d7cafbcad1e24ce7c7ab08943c5751d8
SRC_URI="https://github.com/1g4-mirror/iw/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-net/libnl:="
BDEPEND="app-dev/pkgconf"

src_prepare() {
	default
	tc-export CC LD PKG_CONFIG
}

src_compile() {
	CFLAGS="${CFLAGS} ${CPPFLAGS}" \
	LDFLAGS="${CFLAGS} ${LDFLAGS}" \
	emake V=1
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" SBINDIR="${EPREFIX}/usr/bin" install
	rm -rf "${ED}"/usr/share/man
}
