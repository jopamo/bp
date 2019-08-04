# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"

SNAPSHOT=8a5215917d1d1a40d7a127c9218fa1c2166954de
SRC_URI="https://github.com/gentoo/portage-utils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static"

PATCHES=( ${FILESDIR}/workaround_broken_build.patch )

DEPEND="lib-dev/iniparser
	app-compression/xz-utils
	static? ( lib-dev/iniparser[static-libs] )"
