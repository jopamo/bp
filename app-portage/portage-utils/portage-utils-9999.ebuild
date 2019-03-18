# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"
EGIT_REPO_URI="https://github.com/gentoo/portage-utils.git"
EGIT_COMMIT=43d8c0998aafc279cdfdb18c715ae945e945138a
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

RDEPEND="lib-dev/iniparser:0"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	static? ( lib-dev/iniparser:0[static-libs] )"

PATCHES=( ${FILESDIR}/portage-utils.patch )
