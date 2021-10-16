# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A unit test framework for C"
HOMEPAGE="https://github.com/libcheck/check"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="subunit test"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
		-DCHECK_ENABLE_SUBUNIT=$(usex subunit ON OFF)
	)

	cmake_src_configure
}
