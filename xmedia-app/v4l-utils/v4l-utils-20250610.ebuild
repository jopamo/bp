# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic xdg

DESCRIPTION="a series of packages for handling media devices"
HOMEPAGE="https://git.linuxtv.org/v4l-utils.git"
SNAPSHOT=b8c26bb16d7589b0593ebb79a423e704c96d9d1d
SRC_URI="https://github.com/gjasny/v4l-utils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/v4l-utils-${SNAPSHOT}

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-fs/sysfsutils
	xgui-lib/qtbase
	xgui-tools/alsa-lib
"

src_prepare() {
	filter-flags -flto*

	default
}

src_install() {
	meson_src_install

	rm -r "${ED}"/usr/lib/gconv || die
}
