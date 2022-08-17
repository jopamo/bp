# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 xdg

DESCRIPTION="A library for file management"
HOMEPAGE="https://github.com/lxde/${PN}"
EGIT_REPO_URI="https://github.com/lxde/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug exif"

DEPEND="
	lib-live/glib
	xgui-live-lib/menu-cache
	xgui-live-app/shared-mime-info
	exif? ( xmedia-live-lib/libexif )
"
BDEPEND="
	app-build/gettext
	app-dev/intltool
	app-dev/pkgconf
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable exif)
		--disable-demo
		--disable-dependency-tracking
		--disable-gtk-doc
		--disable-old-actions
		--disable-static
		--disable-udisks
		--with-gtk=3
	)
	econf ${myconf[@]}
}

src_install() {
	default
	rm "${ED}"/usr/include/libfm/{fm-extra.h,fm-version.h,fm-xml-file.h}*
	rm "${ED}"/usr/lib/libfm-extra*
	rm "${ED}"/usr/lib/pkgconfig/libfm-extra.pc
}
