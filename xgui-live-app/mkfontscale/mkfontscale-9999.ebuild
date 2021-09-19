# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="create an index of scalable font files for X"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-lib/libfontenc
	xgui-misc/freetype
	lib-core/zlib
	app-compression/bzip2
	xgui-live-app/util-macros
	xgui-live-app/xorgproto
	app-compression/pigz
"

src_prepare() {
	eautoreconf
	default
}
