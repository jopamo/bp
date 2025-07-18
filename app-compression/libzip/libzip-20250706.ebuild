# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake multibuild flag-o-matic

DESCRIPTION="Library for manipulating zip archives"
HOMEPAGE="https://nih.at/libzip/"
SNAPSHOT=dd450e6ed6faa446518ff6017305b62fd7d55a17
SRC_URI="https://github.com/nih-at/libzip/archive/${SNAPSHOT}.tar.gz -> libzip-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libzip-${SNAPSHOT}

LICENSE="BSD"
SLOT="0/5"
KEYWORDS="amd64 arm64"

IUSE="bzip2 gnutls lzma mbedtls ssl static-libs test tools zstd"

REQUIRED_USE="test? ( tools )"

RESTRICT="!test? ( test )"

DEPEND="
	lib-core/zlib
	bzip2? ( app-compression/bzip2:= )
	lzma? ( app-compression/xz-utils )
	ssl? (
		gnutls? (
			lib-core/nettle:0=
			lib-net/gnutls:=
		)
		!gnutls? (
			mbedtls? ( lib-misc/mbedtls:= )
			!mbedtls? ( virtual/ssl:0= )
		)
	)
	zstd? ( app-compression/zstd )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	# Upstream doesn't support building dynamic & static
	# simultaneously: https://github.com/nih-at/libzip/issues/76
	MULTIBUILD_VARIANTS=( shared $(usev static-libs) )
}

src_configure() {
	append-lfs-flags
	myconfigure() {
		local mycmakeargs=(
			-DBUILD_EXAMPLES=OFF # nothing is installed
			-DENABLE_COMMONCRYPTO=OFF # not in tree
			-DENABLE_BZIP2=$(usex bzip2)
			-DENABLE_LZMA=$(usex lzma)
			-DENABLE_ZSTD=$(usex zstd)
		)
		if [[ ${MULTIBUILD_VARIANT} = static-libs ]]; then
			mycmakeargs+=(
				-DBUILD_DOC=OFF
				-DBUILD_EXAMPLES=OFF
				-DBUILD_SHARED_LIBS=OFF
				-DBUILD_TOOLS=OFF
			)
		else
			mycmakeargs+=(
				-DBUILD_DOC=ON
				-DBUILD_REGRESS=$(usex test)
				-DBUILD_TOOLS=$(usex tools)
			)
		fi

		if use ssl; then
			if use gnutls; then
				mycmakeargs+=(
					-DENABLE_GNUTLS=$(usex gnutls)
					-DENABLE_MBEDTLS=OFF
					-DENABLE_OPENSSL=OFF
				)
			elif use mbedtls; then
				mycmakeargs+=(
					-DENABLE_GNUTLS=OFF
					-DENABLE_MBEDTLS=$(usex mbedtls)
					-DENABLE_OPENSSL=OFF
				)
			else
				mycmakeargs+=(
					-DENABLE_GNUTLS=OFF
					-DENABLE_MBEDTLS=OFF
					-DENABLE_OPENSSL=ON
				)
			fi
		else
			mycmakeargs+=(
				-DENABLE_GNUTLS=OFF
				-DENABLE_MBEDTLS=OFF
				-DENABLE_OPENSSL=OFF
			)
		fi
		cmake_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake_src_compile
}

src_test() {
	run_tests() {
		[[ ${MULTIBUILD_VARIANT} = shared ]] && cmake_src_test
	}

	multibuild_foreach_variant run_tests
}

src_install() {
	multibuild_foreach_variant cmake_src_install
}
