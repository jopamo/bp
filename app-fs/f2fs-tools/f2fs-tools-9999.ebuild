# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Tools for Flash-Friendly File System (F2FS)"
HOMEPAGE="https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/about/"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-core/util-linux"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
