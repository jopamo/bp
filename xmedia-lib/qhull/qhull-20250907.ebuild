# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake 

DESCRIPTION="Geometry library"
HOMEPAGE="http://www.qhull.org"

SNAPSHOT=d1c2fc0caa5f644f3a0f220290d4a868c68ed4f6
SRC_URI="https://github.com/qhull/qhull/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0/$(ver_cut 1-2 "${MY_PV}")"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ppc ppc64 ~riscv ~s390 ~sparc x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos"
IUSE="doc static-libs tools test"
RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( tools )"

DOCS=(
	Announce.txt
	File_id.diz
	README.txt
	REGISTER.txt
)

src_prepare() {
	if ! use doc ; then
		sed -i \
			-e '/^install(DIRECTORY html/d' \
			-e '/^[[:blank:]]*index.htm/d' \
			CMakeLists.txt || die
	fi

	cmake_src_prepare
}

src_configure() {
	use static-libs && lto-guarantee-fat

	local mycmakeargs=(
		# NOTE undo CMakeLists.txt: "Define shared library for reentrant qhull (installed)" as it yields broken RPATH
		-DCMAKE_INSTALL_NAME_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_RPATH="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_RPATH_USE_LINK_PATH="no"
		-DCMAKE_BUILD_WITH_INSTALL_RPATH="yes"

		-DBUILD_APPLICATIONS="$(usex tools)"
		-DBUILD_STATIC_LIBS="$(usex static-libs)"
		-DQHULL_ENABLE_TESTING="$(usex test)"
		-DLINK_APPS_SHARED="yes"
		# -DLINK_APPS_SHARED="$(usex !static-libs)"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if ! use static-libs; then
		rm "${ED}/usr/$(get_libdir)/pkgconfig/qhull"{static,static_r,cpp}.pc || die
	else
		strip-lto-bytecode "${ED}/usr/$(get_libdir)/libqhull"{static,static_r,cpp}.a
	fi
}
