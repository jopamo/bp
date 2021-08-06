# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"
EGIT_REPO_URI="https://github.com/ARMmbed/mbedtls.git"
EGIT_BRANCH="mbedtls-$(ver_cut 1).$(ver_cut 2)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="havege programs test zlib"

RDEPEND="app-misc/ca-certificates
	programs? ( lib-net/libressl )
	zlib? ( >=lib-core/zlib-1.2.8-r1 )"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl )"

enable_mbedtls_option() {
	local myopt="$@"
	# check that config.h syntax is the same at version bump
	sed -i \
		-e "s://#define ${myopt}:#define ${myopt}:" \
		include/mbedtls/config.h || die
}

src_prepare() {
	use zlib && enable_mbedtls_option MBEDTLS_ZLIB_SUPPORT
	use havege && enable_mbedtls_option MBEDTLS_HAVEGE_C

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_PROGRAMS=$(usex programs)
		-DENABLE_ZLIB_SUPPORT=$(usex zlib)
		-DUSE_STATIC_MBEDTLS_LIBRARY=OFF
		-DENABLE_TESTING=$(usex test)
		-DUSE_SHARED_MBEDTLS_LIBRARY=ON
		-DINSTALL_MBEDTLS_HEADERS=ON
		-DLIB_INSTALL_DIR="/usr/lib"
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_test() {
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BUILD_DIR}/library" \
		cmake_src_test
}

src_install() {
	cmake_src_install

	if use programs ; then
		# avoid file collisions with app-core/coreutils
		local p e
		for p in "${ED%/}"/usr/bin/* ; do
			if [[ -x "${p}" && ! -d "${p}" ]] ; then
				mv "${p}" "${ED%/}"/usr/bin/mbedtls_${p##*/} || die
			fi
		done
		for e in aes hash pkey ssl test ; do
			docinto "${e}"
			dodoc programs/"${e}"/*.c
			dodoc programs/"${e}"/*.txt
		done
	fi
}
