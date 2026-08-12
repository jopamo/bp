# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Hardware Lister"
HOMEPAGE="https://www.ezix.org/project/wiki/HardwareLiSter"
SNAPSHOT=50895cca394621b4014a11b78f2b6b78f353631f
SRC_URI="https://github.com/lyonel/lshw/archive/${SNAPSHOT}.tar.gz -> lshw-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lshw-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

#PATCHES=( "${FILESDIR}"/lshw-build.patch )

src_prepare() {
	default

	sed -i \
		-e 's:\<pkg-config\>:${PKG_CONFIG}:' \
		src/Makefile src/gui/Makefile || die
}

src_compile() {
	tc-export CC CXX AR PKG_CONFIG
	use static && append-ldflags -static

	emake \
		SQLITE=0 \
		all
}

src_install() {
	emake DESTDIR="${D}" SBINDIR="${EPREFIX}/usr/bin" PREFIX="${EPREFIX}/usr" install
	cleanup_install
}
