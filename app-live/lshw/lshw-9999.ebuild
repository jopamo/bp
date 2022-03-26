# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs git-r3

DESCRIPTION="Hardware Lister"
HOMEPAGE="https://www.ezix.org/project/wiki/HardwareLiSter"
EGIT_REPO_URI="https://github.com/lyonel/lshw.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="app-core/pciutils"

PATCHES=( ${FILESDIR}/lshw-build.patch )

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
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	cleanup_install

	dosym -r /usr/share/misc/pci.ids /usr/share/lshw/pci.ids
}
