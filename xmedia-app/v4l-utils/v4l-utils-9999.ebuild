# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson flag-o-matic xdg

DESCRIPTION="a series of packages for handling media devices"
HOMEPAGE="https://git.linuxtv.org/v4l-utils.git"
EGIT_REPO_URI="https://git.linuxtv.org/v4l-utils"

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
