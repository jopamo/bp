# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="https://www.gnu.org/software/patch/patch.html"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test xattr"

DEPEND="
	xattr? ( app-core/attr )
	test? ( app-core/ed )
"

src_configure() {
	use static && append-ldflags -static

	econf $(use_enable xattr)
}
