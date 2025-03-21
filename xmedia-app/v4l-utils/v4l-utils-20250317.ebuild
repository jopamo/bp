# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic xdg

DESCRIPTION="a series of packages for handling media devices"
HOMEPAGE="https://git.linuxtv.org/v4l-utils.git"

SNAPSHOT=75e3f0e2c2cba0799744aed10b7c5be66bfe31c2
SRC_URI="https://github.com/gjasny/v4l-utils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

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
