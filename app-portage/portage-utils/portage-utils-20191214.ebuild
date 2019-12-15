# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"

SNAPSHOT=e5ff6caad2f4b848f77e6de82c866fa42aba30ae
SRC_URI="https://github.com/gentoo/portage-utils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="
	static? ( lib-dev/iniparser:0[static-libs] )
	!static? ( lib-dev/iniparser:0 )
"

src_configure() {
	econf \
		--disable-maintainer-mode \
		--with-eprefix="${EPREFIX}" \
		--disable-qmanifest \
		--disable-qtegrity \
		--disable-openmp \
		$(use_enable static)
}
