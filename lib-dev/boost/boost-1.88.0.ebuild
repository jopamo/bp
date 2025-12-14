# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

MY_P="${PN}_$(ver_rs 1- _)"
MAJOR_V="$(ver_cut 1-2)"

DESCRIPTION="Boost Libraries for C++"
HOMEPAGE="http://www.boost.org/"
SRC_URI="https://downloads.sourceforge.net/project/boost/${PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
S="${WORKDIR}/${MY_P}"

KEYWORDS="amd64 arm64"

IUSE="context icu static-libs tools bzip2 zlib lzma zstd"

DEPEND="
	bzip2? ( app-compression/bzip2 )
	icu? ( lib-dev/icu )
	lzma? ( app-compression/xz-utils )
	zlib? ( lib-core/zlib )
	zstd? ( app-compression/zstd )
"
BDEPEND="lib-dev/boost-build"

RESTRICT="test"

ejam() {
	local b2_opts=(
		"$@"
	)
	echo b2 "${b2_opts[@]}"
	b2 "${b2_opts[@]}"
}

src_configure() {
	append-flags -ffat-lto-objects

	OPTIONS=(
		$(usex context '' '--without-context --without-coroutine --without-fiber')
		$(usex icu "-sICU_PATH=${ESYSROOT}/usr" '--disable-icu boost.locale.icu=off')
		--without-locale
		--layout=system
		--no-cmake-config
		--prefix="${EPREFIX}/usr"
		--without-mpi
		--without-python
		--without-stacktrace
		-d+2
		-q
		-sNO_BZIP2=$(usex bzip2 0 1)
		-sNO_LZMA=$(usex lzma 0 1)
		-sNO_ZLIB=$(usex zlib 0 1)
		-sNO_ZSTD=$(usex zstd 0 1)
		cflags="${CPPFLAGS} ${CFLAGS}"
		cxxflags="${CPPFLAGS} ${CXXFLAGS}"
		link=$(usex static-libs shared,static shared)
		linkflags="${LDFLAGS}"
		pch=off
		threading=multi
		variant=release
		debug-symbols=off
	)
}

src_compile() {
	ejam "${OPTIONS[@]}" || die
}

src_install() {
	ejam \
		"${OPTIONS[@]}" \
		--includedir="${ED}/usr/include" \
		--libdir="${ED}/usr/lib" \
		install || die "Installation of Boost libraries failed"
}
