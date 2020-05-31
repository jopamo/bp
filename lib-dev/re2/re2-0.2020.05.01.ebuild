# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic

# Different date format used upstream.
RE2_VER=${PV#0.}
RE2_VER=${RE2_VER//./-}

DESCRIPTION="An efficient, principled regular expression library"
HOMEPAGE="https://github.com/google/re2"
SRC_URI="https://github.com/google/re2/archive/${RE2_VER}.tar.gz -> re2-${RE2_VER}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

S="${WORKDIR}/re2-${RE2_VER}"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	for x in libre2.so.1 libre2.so.1.0 ; do
		dosym libre2.so usr/lib/${x}
	done
}
