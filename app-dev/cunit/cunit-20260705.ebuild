# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=67cee3f06e4bed117738ae4acf0b98f711a621ad
EGIT_REPO_URI="https://gitlab.com/cunity/cunit.git"
EGIT_COMMIT="${SNAPSHOT}"

inherit cmake git-snapshot qa-policy

DESCRIPTION="C unit testing framework"
HOMEPAGE="https://gitlab.com/cunity/cunit"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/cunit-install-metadata.patch" )

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-DCUNIT_DISABLE_TESTS=$(usex test OFF ON)
		-DCUNIT_DISABLE_EXAMPLES=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
