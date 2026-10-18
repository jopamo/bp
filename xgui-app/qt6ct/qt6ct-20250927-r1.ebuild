# Distributed under the terms of the GNU General Public License v2

inherit qmake-utils

DESCRIPTION="Qt6 Configuration Tool (for DE/WM without Qt integration)"
HOMEPAGE="https://www.opencode.net/trialuser/qt6ct/"
SNAPSHOT=00823e41aa60e8fe266d5aee328e82ad1ad94348
SRC_URI="https://www.opencode.net/trialuser/qt6ct/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=xgui-lib/qtbase-6.2:6="
RDEPEND="${DEPEND}
	>=xgui-app/kvantum-20261006
"
BDEPEND="
	>=xgui-lib/qtbase-6.2:6
	xgui-lib/qttools:6
"

src_configure() {
	eqmake6
}

src_install() {
	emake install INSTALL_ROOT="${D}"

	insinto /etc/xdg/qt6ct
	doins "${FILESDIR}"/qt6ct.conf

	newenvd - 98${PN} <<-EOF
		QT_QPA_PLATFORMTHEME=qt6ct
	EOF
}

pkg_postinst() {
	elog "Log in again to load QT_QPA_PLATFORMTHEME=qt6ct."
	elog "Existing ~/.config/qt6ct/qt6ct.conf files override the system defaults."
	elog "To use Kvantum's colors and painting, select kvantum-dark in qt6ct,"
	elog "disable its custom palette, and clear the selected style sheets."
}
