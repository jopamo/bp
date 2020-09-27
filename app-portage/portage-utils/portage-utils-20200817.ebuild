# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"

SNAPSHOT=e55f582c4c129ece9037575135a95f98a91a210f
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
