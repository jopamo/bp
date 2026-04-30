# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="An open-source JPEG 2000 library"
HOMEPAGE="http://www.openjpeg.org"
SNAPSHOT=530bebdb3fb40ed177390ebc001ae56d7f14a667
SRC_URI="https://github.com/uclouvain/openjpeg/archive/${SNAPSHOT}.tar.gz -> openjpeg-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/openjpeg-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="test"

DEPEND="
	xgui-lib/lcms
	xmedia-lib/libpng
	xmedia-lib/tiff
	lib-core/zlib
"

src_configure() {
	qa-policy-configure
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
		-DBUILD_DOC=OFF
		-DBUILD_CODEC=ON
		-DBUILD_STATIC_LIBS="$(usex static-libs)"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install

	dosym -r /usr/include/openjpeg-2.5/opj_config.h /usr/include/opj_config.h
	dosym -r /usr/include/openjpeg-2.5/openjpeg.h /usr/include/openjpeg.h
	dosym -r /usr/include/openjpeg-2.5/opj_stdint.h /usr/include/opj_stdint.h
}
