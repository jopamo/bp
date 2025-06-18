# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Collection of patches for libtool.eclass"
HOMEPAGE="https://gitweb.gentoo.org/proj/elt-patches.git/"

SNAPSHOT=70aedc615d442d0a6614f36bde33d92aaccc3b6a
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
