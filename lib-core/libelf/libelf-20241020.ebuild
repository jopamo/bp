# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SRC_URI="https://sourceware.org/elfutils/ftp/${PV}/${P}.tar.bz2"

SNAPSHOT="b5edd4a1e45d359ec3fccd91f4fde9514635f220"
SRC_URI="https://github.com/arachsys/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${EPREFIX}"/usr/lib
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${EPREFIX}"/usr/lib install
}
