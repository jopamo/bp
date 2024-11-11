# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Tools for Flash-Friendly File System (F2FS)"
HOMEPAGE="https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/about/"

SNAPSHOT=05fde8ed32dbb66c7cae57627cc4e51eafcf167a
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/snapshot/f2fs-tools-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
