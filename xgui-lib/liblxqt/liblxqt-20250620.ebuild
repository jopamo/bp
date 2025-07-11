# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Common base library for the LXQt desktop environment"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=56e497cee59d13948fa2b41c93bd8b9076217a5c
SRC_URI="https://github.com/lxqt/liblxqt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/liblxqt-${SNAPSHOT}

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

src_configure() {
	local mycmakeargs=(
		-DBUILD_BACKLIGHT_LINUX_BACKEND=OFF
	)
	cmake_src_configure
}
