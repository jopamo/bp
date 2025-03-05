# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SVG-based theme engine for Qt, KDE Plasma and LXQt"
HOMEPAGE="https://github.com/tsujan/Kvantum"

SNAPSHOT=0d82f557141f01402bd8afe4aad0e442c04a9988
SRC_URI="https://github.com/tsujan/Kvantum/archive/${SNAPSHOT}.tar.gz -> kvantum-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Kvantum-${SNAPSHOT}/Kvantum"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

RDEPEND="xgui-lib/qtsvg:6"
BDEPEND="xgui-lib/qttools:6"

src_configure() {
	local mycmakeargs=(
		-DENABLE_QT4=OFF
		-DENABLE_QT5=OFF
		-DWITHOUT_KF=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	cat > "${T}"/99${PN} <<- EOF || die
		QT_STYLE_OVERRIDE=kvantum
	EOF
	doenvd "${T}"/99${PN}
}
