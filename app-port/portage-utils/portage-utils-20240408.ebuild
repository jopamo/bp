# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/gentoo/portage-utils.git"
	inherit git-r3
else
	SNAPSHOT=9594126239e0d21b88c3b8c535b6635b4a8b8892
	SRC_URI="https://github.com/gentoo/portage-utils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

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
