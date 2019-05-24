# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="https://www.gnu.org/software/patch/patch.html"
SRC_URI="https://ftp.gnu.org/gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static test xattr"

DEPEND="xattr? ( sys-app/attr )
		test? ( sys-app/ed )"

PATCHES=( 	${FILESDIR}/tmp_and_ed_cleanup.patch
	)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static

	econf $(use_enable xattr)
}
