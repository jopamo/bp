# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib git-r3

DESCRIPTION="Binary-decimal and decimal-binary conversion routines for IEEE doubles"
HOMEPAGE="https://github.com/google/double-conversion"
EGIT_REPO_URI="https://github.com/google/double-conversion.git"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64 x86"

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)

	cmake-utils_src_configure
}

multilib_src_install() {
	dolib.so libdouble-conversion.so*
	insinto /usr/include/double-conversion
	doins ${S}/double-conversion/{double-conversion,utils}.h
}
