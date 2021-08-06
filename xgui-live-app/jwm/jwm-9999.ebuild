# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools python-r1 git-r3

DESCRIPTION=" a light-weight window manager for the X11 Window System"
HOMEPAGE="http://openbox.org/"
EGIT_REPO_URI="https://github.com/joewing/jwm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bidi cairo debug iconv jpeg nls png truetype xinerama xpm"

DEPEND="
	xgui-live-lib/librsvg
	xgui-live-lib/cairo
	lib-media/libjpeg-turbo
	lib-media/libpng
	x11-live-lib/libXext
	x11-live-lib/libXrender
	x11-live-lib/libXmu
	x11-live-lib/libXinerama
	x11-live-lib/libXpm
"

src_prepare() {
	touch config.rpath

	eaclocal
	automake -ac

	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_enable cairo) \
		$(use_enable debug) \
		$(use_enable jpeg) \
		$(use_enable nls) \
		$(use_enable png) \
		$(use_enable cairo rsvg) \
		$(use_enable truetype xft) \
		$(use_enable xinerama) \
		$(use_enable xpm) \
		$(use_with iconv libiconv-prefix /usr) \
		$(use_with nls libintl-prefix /usr) \
		--enable-shape \
		--enable-xrender \
		--disable-rpath
}
