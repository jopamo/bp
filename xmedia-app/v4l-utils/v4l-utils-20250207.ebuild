# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic xdg

DESCRIPTION="a series of packages for handling media devices"
HOMEPAGE="https://git.linuxtv.org/v4l-utils.git"

SNAPSHOT=77f5df419204d17e025a188676eafef185c603cb
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
