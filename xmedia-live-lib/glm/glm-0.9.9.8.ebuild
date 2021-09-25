# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="OpenGL Mathematics"
HOMEPAGE="http://glm.g-truc.net/"
SRC_URI="https://github.com/g-truc/glm/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( HappyBunny MIT )"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}"/${PN}-0.9.9.6-simd.patch
	"${FILESDIR}"/${P}-clang.patch
	"${FILESDIR}"/${PN}-0.9.9.8-big-endian-tests.patch
)

src_configure() {
	sed \
		-e "s:@CMAKE_INSTALL_PREFIX@:${EPREFIX}/usr:" \
		-e "s:@GLM_VERSION@:$(ver_cut 1-3):" \
		"${FILESDIR}"/glm.pc.in \
		> "${BUILD_DIR}/glm.pc" || die

	cmake_src_configure
}

src_install() {
	doheader -r glm
	insinto /usr/share/pkgconfig
	doins "${BUILD_DIR}/glm.pc"
	insinto /usr/share
	doins -r cmake
	dodoc readme.md manual.md
}
