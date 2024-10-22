# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Tools to make diffs and compare files"
HOMEPAGE="https://www.gnu.org/software/diffutils/"
SRC_URI="
	https://1g4.org/files/${P}.tar.xz
	mirror://gnu/diffutils/${P}.tar.xz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="app-compression/xz-utils"

BDEPEND="app-dev/gperf"

src_configure() {
	use static && append-ldflags -static

	# Disable automagic dependency over libsigsegv; see bug #312351.
	export ac_cv_libsigsegv=no

	econf --disable-nls
}

src_test() {
	# explicitly allow parallel testing
	emake check
}
