# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="SVG-based theme engine for Qt, KDE Plasma and LXQt"
HOMEPAGE="https://github.com/tsujan/Kvantum"

SNAPSHOT=8acc24e13ffea00e7b4b50abc0fdf81b59757465
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

	insinto /usr/share/color-schemes
	doins "${FILESDIR}"/KvGnomeDark.colors

	#cat > "${T}"/99${PN} <<- EOF || die
	#	QT_STYLE_OVERRIDE=kvantum
	#EOF
	#doenvd "${T}"/99${PN}
}
