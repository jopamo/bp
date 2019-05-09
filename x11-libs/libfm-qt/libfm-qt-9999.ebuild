# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Qt port of libfm, a library providing components to build desktop file managers"
HOMEPAGE="http://lxqt.org/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=
	SRC_URI="https://github.com/lxqt/libfm-qt/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1+"
SLOT="0/3"

RDEPEND="
	lib-dev/glib:2
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	>=x11-libs/libfm-1.2.0:=
	x11-libs/libxcb:=
	dev-util/lxqt-build-tools
"
DEPEND="${RDEPEND}
	gui-lib/linguist-tools:5
	dev-util/pkgconf
	lib-media/libexif
"

src_install() {
	cmake-utils_src_install
	rm -rf "${ED}"/usr/share/{mime,doc}
}
