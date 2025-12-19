# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Cross-platform asynchronous I/O and event loop library (libuv)"
HOMEPAGE="https://github.com/libuv/libuv"
SNAPSHOT=ec7ec98b70149bafc2f8d57b9e4133e2f2570d52
SRC_URI="https://github.com/libuv/libuv/archive/${SNAPSHOT}.tar.gz -> libuv-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libuv-${SNAPSHOT}"

LICENSE="BSD BSD-2 ISC MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

BDEPEND="
	app-build/libtool
	app-dev/pkgconf
"

src_prepare() {
	default

	echo "m4_define([UV_EXTRA_AUTOMAKE_FLAGS], [serial-tests])" \
		> m4/libuv-extra-automake-flags.m4 || die

	eautoreconf
}

src_configure() {
	local myconf=(
		cc_cv_cflags__g=no
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_test() {
	mkdir "${BUILD_DIR}"/test || die
	cp -pPR "${S}"/test/fixtures "${BUILD_DIR}"/test/fixtures || die
	default
}
