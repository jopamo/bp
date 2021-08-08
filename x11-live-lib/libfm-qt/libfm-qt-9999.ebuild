# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Qt port of libfm, a library providing components to build desktop file managers"
HOMEPAGE="http://lxqt.org/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=
	SRC_URI="https://github.com/lxqt/libfm-qt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1+"
SLOT="0"

DEPEND="
	lib-live/glib:2
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras:5
	>=x11-live-lib/libfm-1.2.0:=
	xgui-live-lib/libxcb
	xmedia-live-lib/libexif
"

BDEPEND="
	dev-util/pkgconf
	dev-util/lxqt-build-tools
"

src_install() {
	cmake_src_install
	rm -rf "${ED}"/usr/share/{mime,doc}
}
