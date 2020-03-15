# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic multiprocessing toolchain-funcs

MY_P="${PN}_$(ver_rs 1- _)"
MAJOR_V="$(ver_cut 1-2)"

DESCRIPTION="Boost Libraries for C++"
HOMEPAGE="http://www.boost.org/"
SRC_URI="https://downloads.sourceforge.net/project/boost/${PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="context icu +nls static-libs tools bzip2 zlib lzma zstd"

RDEPEND="
	icu? ( lib-dev/icu )
	bzip2? ( app-compression/bzip2 )
	zlib? ( lib-sys/zlib )
	lzma? ( app-compression/xz-utils )
	zstd? ( app-compression/zstd )
	app-compression/bzip2
	lib-sys/zlib
	!app-admin/eselect-boost"
DEPEND="${RDEPEND}
	=lib-dev/boost-build-${MAJOR_V}*"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-1.71.0-disable_icu_rpath.patch
	"${FILESDIR}"/${PN}-1.71.0-build-auto_index-tool.patch
	"${FILESDIR}"/${PN}-1.72.0-missing-serialization-split_member-include.patch
	"${FILESDIR}"/${PN}-1.72.0-revert-cease-dependence-on-range.patch
)

append-cxxflags -std=c++14

ejam() {
	local b2_opts=(
		"$@"
	)
	echo b2 "${b2_opts[@]}"
	b2 "${b2_opts[@]}"
}

src_configure() {
	# Workaround for too many parallel processes requested, bug #506064
	[[ "$(makeopts_jobs)" -gt 64 ]] && MAKEOPTS="${MAKEOPTS} -j64"

	OPTIONS=(
		"-j$(makeopts_jobs)"
		-q
		-d+2
		pch=off
		$(usex icu "-sICU_PATH=${ESYSROOT}/usr" '--disable-icu boost.locale.icu=off')
		--without-mpi
		$(usex nls '' '--without-locale')
		$(usex context '' '--without-context --without-coroutine --without-fiber')
		--without-stacktrace
		--boost-build="${BROOT}"/usr/share/boost-build
		--prefix="${ED}/usr"
		--layout=system
		--no-cmake-config
		threading=multi
		link=$(usex static-libs shared,static shared)
		-sNO_BZIP2=$(usex bzip2 0 1)
		-sNO_LZMA=$(usex lzma 0 1)
		-sNO_ZLIB=$(usex zlib 0 1)
		-sNO_ZSTD=$(usex zstd 0 1)
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
