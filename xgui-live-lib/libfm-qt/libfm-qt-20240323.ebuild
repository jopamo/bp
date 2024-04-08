# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt port of libfm, a library providing components to build desktop file managers"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=a82a682daf37e0eaba446d1925f61b09c5b79217
SRC_URI="https://github.com/lxqt/libfm-qt/archive/${SNAPSHOT}.tar.gz -> libfm-qt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libfm-qt-${SNAPSHOT}"

if [[ "${PV}" == "9999" ]]; then
	inherit
	EGIT_REPO_URI="https://github.com/lxqt/libfm-qt"
else
	SNAPSHOT=a82a682daf37e0eaba446d1925f61b09c5b79217
	SRC_URI="https://github.com/lxqt/libfm-qt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/glib
	xgui-lib/qtbase:6
	xgui-live-lib/libfm
	xgui-live-lib/libxcb
	xmedia-live-lib/libexif
"

BDEPEND="
	app-dev/pkgconf
	app-dev/lxqt-build-tools
"

src_install() {
	cmake_src_install
	rm -rf "${ED}"/usr/share/{mime,doc}
}
