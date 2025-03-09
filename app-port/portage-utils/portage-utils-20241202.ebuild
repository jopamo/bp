# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"

SNAPSHOT=1833294774ebfb4bcc1464e6ae28e71da0f6babf
SRC_URI="https://github.com/gentoo/portage-utils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="
	static? ( lib-core/iniparser:0[static-libs] )
	!static? ( lib-core/iniparser:0 )
"

src_configure() {
	local myconf=(
		--disable-maintainer-mode
		--with-eprefix="${EPREFIX}"
		--disable-qmanifest
		--disable-qtegrity
		--disable-openmp
		$(use_enable static)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
