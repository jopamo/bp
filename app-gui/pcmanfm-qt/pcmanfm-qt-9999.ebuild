# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="https://github.com/lxqt/pcmanfm-qt"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://www.github.com/lxqt/${PN}"
else
	SNAPSHOT=9458ba41d94327ab833e1134d76c4eb67a7a799b
	SRC_URI="https://github.com/lxqt/pcmanfm-qt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	>=lib-dev/glib-2.18:2
	lib-gui/qtbase
	lib-gui/qtx11extras:5
	>=x11-live-libs/libfm-1.2.0:=
	x11-live-libs/libfm-qt:=
	lib-gui/libxcb
	>=dev-util/intltool-0.40
"

src_install() {
	cmake_src_install

	insinto etc/xdg/${PN}/default
	doins ${FILESDIR}/settings.conf
}
