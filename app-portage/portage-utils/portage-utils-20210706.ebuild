# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/gentoo/portage-utils.git"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=a7fdc5749013b873ec1df8113d3f28e8e624551d
	SRC_URI="https://github.com/gentoo/portage-utils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="static"

DEPEND="static? ( lib-core/iniparser:0[static-libs] )
	!static? ( lib-core/iniparser:0 )"

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
