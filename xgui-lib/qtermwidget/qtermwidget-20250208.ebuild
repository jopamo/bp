# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Qt terminal emulator widget"
HOMEPAGE="https://github.com/lxqt/qtermwidget"

SNAPSHOT=c3f6de38b1856b3b385933d3b4fae53de23ad39b
SRC_URI="https://github.com/lxqt/qtermwidget/archive/${SNAPSHOT}.tar.gz -> qtermwidget-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qtermwidget-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase
	lib-dev/libutf8proc
"

BDEPEND="app-dev/lxqt-build-tools"

src_configure() {
	local mycmakeargs=(
		-DUSE_UTF8PROC=ON
	)

	cmake_src_configure
}
