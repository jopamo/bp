# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="create an index of scalable font files for X"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-compression/bzip2
	app-compression/pigz
	lib-core/zlib
	xgui-live-app/util-macros
	xgui-live-app/xorgproto
	xgui-live-lib/libfontenc
	xgui-misc/freetype
"

src_prepare() {
	default
	eautoreconf
}
