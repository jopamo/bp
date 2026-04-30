# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SNAPSHOT=1a8a405527f42bb6cd89ba0347dab77d486e4af5
SRC_URI="https://github.com/arachsys/libelf/archive/${SNAPSHOT}.tar.gz -> libelf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libelf-${SNAPSHOT}"

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
