# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake python-any-r1 git-r3

DESCRIPTION="An implementation of basic iCAL protocols"
HOMEPAGE="https://github.com/libical/libical"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="|| ( MPL-2.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+glib +introspection static-libs test"

RESTRICT="!test? ( test )"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DICAL_BUILD_DOCS=OFF
		-DICAL_GLIB=$(usex glib)
		-DGOBJECT_INTROSPECTION=$(usex introspection)
		-DSHARED_ONLY=$(usex !static-libs)
		-DLIBICAL_BUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	local myctestargs=(
		-E "(icalrecurtest|icalrecurtest-r)" # bug 660282
	)

	cmake_src_test
}
