# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Tools to make diffs and compare files"
HOMEPAGE="https://www.gnu.org/software/diffutils/"
SRC_URI="mirror://gnu/diffutils/${P}.tar.xz"

#SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static"

DEPEND="app-compression/xz-utils
	nls? ( sys-devel/gettext )"

BDEPEND="dev-util/gperf"

src_configure() {
	use static && append-ldflags -static

	# Disable automagic dependency over libsigsegv; see bug #312351.
	export ac_cv_libsigsegv=no

	local myconf=(
		$(use_enable nls)
	)
	econf "${myconf[@]}"
}

src_test() {
	# explicitly allow parallel testing
	emake check
}
