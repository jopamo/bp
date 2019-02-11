# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Collection of patches for libtool.eclass"
HOMEPAGE="https://gitweb.gentoo.org/proj/elt-patches.git/"
SRC_URI="https://dev.gentoo.org/~mgorny/dist/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="sys-app/gentoo-functions"
DEPEND="app-compression/xz-utils"

src_compile() {
	emake rootprefix="${EPREFIX%/}" libdirname="$(get_libdir)"
}

src_install() {
	emake DESTDIR="${D}" rootprefix="${EPREFIX%/}" install
}
