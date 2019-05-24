# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs git-r3

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="https://github.com/rofl0r/proxychains-ng/"
EGIT_REPO_URI="https://github.com/rofl0r/proxychains-ng.git"

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
		--libdir="${EPREFIX}"/usr/lib64 \
		--sysconfdir="${EPREFIX}"/etc \
		|| die
}

src_install() {
	dobin ${PN}4
	dosym ${PN}4 /usr/bin/${PN}

	dolib.so lib${PN}4.so.${PV}
	dosym lib${PN}4.so.${PV} /usr/lib64/lib${PN}.so.${PV:0:1}
	dosym lib${PN}4.so.${PV} /usr/lib64/lib${PN}.so

	insinto /etc
	doins src/${PN}.conf
}
