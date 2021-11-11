# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Qt terminal emulator widget"
HOMEPAGE="https://github.com/lxqt/qtermwidget"
EGIT_REPO_URI="https://github.com/lxqt/qtermwidget.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-lib/qtbase
	lib-dev/libutf8proc
"

BDEPEND="app-dev/lxqt-build-tools"

src_configure() {
	local mycmakeargs=(
		-DUSE_UTF8PROC=ON
	)

	cmake_src_configure
}
