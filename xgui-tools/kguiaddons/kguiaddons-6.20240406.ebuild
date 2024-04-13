# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Framework providing assorted high-level user interface components"

SNAPSHOT=0efca934f0fd69e93f4339b4c73f85adb3e0f478
SRC_URI="https://github.com/KDE/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
#KEYWORDS="amd64 arm64"

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
