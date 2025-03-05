# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt port of libfm, a library providing components to build desktop file managers"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=1dde9cfef871114acda98880ce85bb27fe7b272d
SRC_URI="https://github.com/lxqt/libfm-qt/archive/${SNAPSHOT}.tar.gz -> libfm-qt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libfm-qt-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-util/glib
	xgui-lib/qtbase:5
	xgui-lib/libfm
	xgui-lib/libxcb
	xmedia-lib/libexif
"

BDEPEND="
	app-dev/pkgconf
	app-dev/lxqt-build-tools
"

src_install() {
	cmake_src_install
	rm -rf "${ED}"/usr/share/{mime,doc}
}
