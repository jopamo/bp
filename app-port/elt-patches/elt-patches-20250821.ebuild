# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Collection of patches for libtool.eclass"
HOMEPAGE="https://gitweb.gentoo.org/proj/elt-patches.git/"
SNAPSHOT=c36508e0c534414fe9b7a944fa9f9d3cf369f193
SRC_URI="https://github.com/gentoo/elt-patches/archive/${SNAPSHOT}.tar.gz -> elt-patches-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/elt-patches-${SNAPSHOT}"

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
