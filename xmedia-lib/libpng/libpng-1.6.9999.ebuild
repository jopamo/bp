# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
EGIT_REPO_URI="https://github.com/glennrp/libpng.git"
EGIT_BRANCH=libpng$(ver_cut 1)$(ver_cut 2)

LICENSE="libpng"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	lib-core/zlib
	app-compression/xz-utils
"

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
