# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools qa-policy

DESCRIPTION="Tools for Flash-Friendly File System (F2FS)"
HOMEPAGE="https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/about/"
SNAPSHOT=3ab67256d83a8323b92992155b99c3365c0964f6
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/snapshot/f2fs-tools-${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/f2fs-tools-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-core/util-linux"
BDEPEND="app-dev/patchelf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure

	default
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete

	qa-policy-install
}
