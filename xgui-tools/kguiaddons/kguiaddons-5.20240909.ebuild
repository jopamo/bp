# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Framework providing assorted high-level user interface components"

SNAPSHOT=c000ae60c77b291c4ea03edc4358efdb77c6bce2
SRC_URI="https://github.com/KDE/kguiaddons/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/kguiaddons-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="wayland? ( xgui-lib/qtwayland )"

src_configure() {
	local mycmakeargs=(
		$(usex wayland '-DWITH_WAYLAND=ON' '-DWITH_WAYLAND=OFF')
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	einfo "Installing environment file..."
	local envfile="${T}/78kf"
	echo "CONFIG_PROTECT=${EPREFIX}/usr/share/config" >> ${envfile}
	doenvd ${envfile}
}
