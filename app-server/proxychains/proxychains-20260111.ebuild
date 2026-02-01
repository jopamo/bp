# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="https://github.com/rofl0r/proxychains-ng/"
SNAPSHOT=78ead0eca16bb4bd4628eb7d5eb99f8d00a1c8e7
SRC_URI="https://github.com/rofl0r/proxychains-ng/archive/${SNAPSHOT}.tar.gz -> proxychains-ng-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/proxychains-ng-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i "s/^\(LDSO_SUFFIX\).*/\1 = so.${PV}/" Makefile || die
	tc-export CC
}

src_configure() {
	# not autotools
	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/lib \
		--sysconfdir="${EPREFIX}"/etc \
		|| die
}

src_install() {
	dobin proxychains4
	dosym -r /usr/bin/proxychains4 /usr/bin/proxychains

	dolib.so libproxychains4.so.${PV}
	dosym -r /usr/lib/libproxychains4.so.${PV} /usr/lib/libproxychains.so.${PV:0:1}
	dosym -r /usr/lib/libproxychains4.so.${PV} /usr/lib/libproxychains.so

	insinto /etc
	doins src/proxychains.conf
}
