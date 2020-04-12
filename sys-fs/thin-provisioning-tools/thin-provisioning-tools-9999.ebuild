# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="A suite of tools for thin provisioning on Linux"
HOMEPAGE="https://github.com/jthornber/thin-provisioning-tools"
EGIT_REPO_URI="https://github.com/jthornber/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

DEPEND="
	static? ( 	lib-dev/expat[static-libs(+)]
				lib-dev/libaio[static-libs(+)]
			)
	test? (
		dev-lang/ruby
		>=dev-cpp/gmock-1.6
		>=dev-cpp/gtest-1.6
		dev-util/cucumber
		dev-util/aruba
	)
	lib-dev/boost"

PATCHES=(
	"${FILESDIR}"/${PN}-0.7.0-build-fixes.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		$(use_enable test testing)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake unit-test
}
