# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="C++ crypto library"
HOMEPAGE="https://botan.randombit.net/"
SNAPSHOT=ddbd8dc5a7fbe71d7a0d3b09c34965270c86d092
SRC_URI="https://github.com/randombit/botan/archive/${SNAPSHOT}.tar.gz -> botan-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/botan-${SNAPSHOT}

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="boost bzip2 lzma static-libs sqlite zlib"

DEPEND="
	boost? ( lib-dev/boost )
	bzip2? ( app-compression/bzip2 )
	lzma? ( app-compression/xz-utils )
	sqlite? ( lib-core/sqlite )
	zlib? ( lib-core/zlib )
"

src_configure() {
	local disable_modules=(
		$(usev !boost 'boost')
	)

	local chostarch="${CHOST%%-*}"

	local myargs=(
		--prefix="${EPREFIX}/usr"
		--docdir=share/doc
		--libdir=lib
		$(use_enable static-libs static-library)
		$(use_with boost)
		$(use_with bzip2)
		$(use_with lzma)
		$(use_with sqlite sqlite3)
		$(use_with zlib)
		--cpu=${chostarch}
		--disable-modules=$( IFS=","; echo "${disable_modules[*]}" )
		--os=linux
		--with-os-feature=getrandom
		--without-documentation
		--without-doxygen
		--without-sphinx
	)

	tc-export CC CXX AR

	${EPYTHON} ./configure.py "${myargs[@]}" || die "configure.py failed with ${EPYTHON}"
}

src_test() {
	LD_LIBRARY_PATH="${S}" ./botan-test || die "Validation tests failed"
}
