# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Qt terminal emulator widget"
HOMEPAGE="https://github.com/lxqt/qtermwidget"
SNAPSHOT=459733aea9af240ea72ca56b566bfd1c42e96a21
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
