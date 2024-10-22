# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="https://github.com/rofl0r/proxychains-ng/"

SNAPSHOT=1760c9347473365394226f176588c3c7e0684dd9
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
	dobin ${PN}4
	dosym ${PN}4 /usr/bin/${PN}

	dolib.so lib${PN}4.so.${PV}
	dosym lib${PN}4.so.${PV} /usr/lib/lib${PN}.so.${PV:0:1}
	dosym lib${PN}4.so.${PV} /usr/lib/lib${PN}.so

	insinto /etc
	doins src/${PN}.conf
}
