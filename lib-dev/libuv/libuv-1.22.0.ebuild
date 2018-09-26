# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools ltprune multilib-minimal

DESCRIPTION="Cross-platform asychronous I/O"
HOMEPAGE="https://github.com/libuv/libuv"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD BSD-2 ISC MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"
RESTRICT="test"

DEPEND="sys-devel/libtool
	dev-util/pkgconfig[${MULTILIB_USEDEP}]"

src_prepare() {
	default

	echo "m4_define([UV_EXTRA_AUTOMAKE_FLAGS], [serial-tests])" \
		> m4/libuv-extra-automake-flags.m4 || die

	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		cc_cv_cflags__g=no
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_test() {
	mkdir "${BUILD_DIR}"/test || die
	cp -pPR "${S}"/test/fixtures "${BUILD_DIR}"/test/fixtures || die
	default
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files
}
