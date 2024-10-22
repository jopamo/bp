# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Collection of patches for libtool.eclass"
HOMEPAGE="https://gitweb.gentoo.org/proj/elt-patches.git/"

SNAPSHOT=4aa3f439d814807d093b2a7731a3b7b25ed520cd
SRC_URI="https://gitweb.gentoo.org/proj/elt-patches.git/snapshot/elt-patches-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}//${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-core/gentoo-functions
		app-compression/xz-utils"

src_compile() {
	emake rootprefix="${EPREFIX}" libdirname="lib"
}

src_install() {
	emake DESTDIR="${D}" rootprefix="${EPREFIX}" install
}
