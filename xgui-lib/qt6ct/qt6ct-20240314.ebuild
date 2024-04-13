# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SVG rendering library for the Qt6 framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT="55dba8704c0a748b0ce9f2d3cc2cf200ca3db464"
SRC_URI="https://github.com/trialuser02/qt6ct/archive/${SNAPSHOT}.tar.gz -> qt6ct-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qt6ct-${SNAPSHOT}"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

src_install() {
	cmake_src_install

	cat > "${T}"/99${PN} <<- EOF || die
		QT_QPA_PLATFORMTHEME=qt6ct
	EOF
	doenvd "${T}"/99${PN}
}
