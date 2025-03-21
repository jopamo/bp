# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Common base library for the LXQt desktop environment"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=87c53b3d46bc40e479e5a150a2bf9bc11295af84
SRC_URI="https://github.com/lxqt/liblxqt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

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
