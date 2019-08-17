# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="https://www.gnu.org/software/patch/patch.html"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static test xattr"

DEPEND="xattr? ( sys-app/attr )
		test? ( sys-app/ed )"

PATCHES=( 	${FILESDIR}/15b158db3ae11cb835f2eb8d2eb48e09d1a4af48.patch
			${FILESDIR}/76e775847f4954b63dc72afe34d9d921c6688b31.patch
			${FILESDIR}/dce4683cbbe107a95f1f0d45fabc304acfb5d71a.patch
)

src_configure() {
	use static && append-ldflags -static

	econf $(use_enable xattr)
}
