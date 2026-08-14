# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy xdg

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/flameshot-org/flameshot"

SNAPSHOT=e408812d77ff1835957f85796c4cf737466bd69d
QT_COLOR_WIDGETS_SNAPSHOT=5d52e907e50dc88cf969b41cea44665ff6c475b1
KDSINGLEAPPLICATION_VERSION=1.2.0
SRC_URI="
	https://github.com/flameshot-org/flameshot/archive/${SNAPSHOT}.tar.gz -> flameshot-${SNAPSHOT}.tar.gz
	https://gitlab.com/mattbas/Qt-Color-Widgets/-/archive/${QT_COLOR_WIDGETS_SNAPSHOT}/Qt-Color-Widgets-${QT_COLOR_WIDGETS_SNAPSHOT}.tar.gz -> flameshot-qt-color-widgets-${QT_COLOR_WIDGETS_SNAPSHOT}.tar.gz
	https://github.com/KDAB/KDSingleApplication/archive/refs/tags/v${KDSINGLEAPPLICATION_VERSION}.tar.gz -> flameshot-kdsingleapplication-${KDSINGLEAPPLICATION_VERSION}.tar.gz
"
S="${WORKDIR}/flameshot-${SNAPSHOT}"

LICENSE="FreeArt GPL-3+ Apache-2.0 LGPL-3+ MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtsvg:6
	xgui-lib/qtbase:6
"

PATCHES=(
	"${FILESDIR}/flameshot-14.0.0-strict-aliasing-remove-task.patch"
)

src_prepare() {
	mkdir -p external/Qt-Color-Widgets external/KDSingleApplication
	tar -xf "${DISTDIR}/flameshot-qt-color-widgets-${QT_COLOR_WIDGETS_SNAPSHOT}.tar.gz" \
		--strip-components=1 -C external/Qt-Color-Widgets
	tar -xf "${DISTDIR}/flameshot-kdsingleapplication-${KDSINGLEAPPLICATION_VERSION}.tar.gz" \
		--strip-components=1 -C external/KDSingleApplication

	default
}

src_configure() {
	local mycmakeargs=(
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DUSE_BUNDLED_KDSINGLEAPPLICATION=ON
		-DUSE_KDSINGLEAPPLICATION=ON
	)

	export GIT_HASH=${SNAPSHOT}
	qa-policy-configure
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# KDSingleApplication is linked statically into Flameshot; do not publish
	# the bundled library's development payload from this application package.
	rm -rf \
		"${D}/usr/include/kdsingleapplication-qt6" \
		"${D}/usr/$(get_libdir)/cmake/KDSingleApplication-qt6"
	rm -f "${D}/usr/$(get_libdir)/libkdsingleapplication-qt6.a"

	qa-policy-install
}
