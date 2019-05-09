# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils virtualx

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/${PN}/${PV}/${P}.tar.xz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"
KEYWORDS="amd64 arm64"
CDEPEND="
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtsvg:5
	gui-lib/qtwidgets:5
	gui-lib/qtxml:5
"
DEPEND="${CDEPEND}
	dev-util/pkgconf
	test? ( gui-lib/qttest:5 )
"
RDEPEND="${CDEPEND}
	x11/xdg-utils
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
	)
	cmake-utils_src_configure
}

src_test() {
	VIRTUALX_COMMAND="cmake-utils_src_test" virtualmake
}
