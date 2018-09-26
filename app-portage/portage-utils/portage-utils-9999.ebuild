# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit toolchain-funcs git-r3

DESCRIPTION="small and fast portage helper tools written in C"
HOMEPAGE="https://wiki.gentoo.org/wiki/Portage-utils"
EGIT_REPO_URI="https://github.com/gentoo/portage-utils.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="nls static"

RDEPEND="lib-dev/iniparser:0"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	static? ( lib-dev/iniparser:0[static-libs] )"

PATCHES=(
		${FILESDIR}/portage-utils.patch
		)
