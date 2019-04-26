# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"

SNAPSHOT=868b2b4b4f5140da7188389acf9f719fcf343ab2
SRC_URI="https://github.com/gentoo/portage-utils/archive/${SNAPSHOT}.zip -> ${P}.zip"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

RDEPEND="lib-dev/iniparser:0"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	static? ( lib-dev/iniparser:0[static-libs] )"

PATCHES=( ${FILESDIR}/portage-utils.patch )
