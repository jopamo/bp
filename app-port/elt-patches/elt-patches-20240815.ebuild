# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Collection of patches for libtool.eclass"
HOMEPAGE="https://gitweb.gentoo.org/proj/elt-patches.git/"

SNAPSHOT=0363623cad91252c8084b3aa0d427f5f8997a873
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
