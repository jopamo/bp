# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 xdg-utils

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
	dev-util/intltool
	dev-util/pkgconf
	sys-devel/gettext
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-dependency-tracking
		--disable-static
		--disable-demo
		$(use_enable exif)
		$(use_enable debug)
		--disable-udisks
		--with-gtk=3
		--disable-gtk-doc
		--disable-old-actions
	)
	econf ${myconf[@]}
}

src_install() {
	default
	rm "${ED}"/usr/include/libfm/{fm-extra.h,fm-version.h,fm-xml-file.h}*
	rm "${ED}"/usr/lib/libfm-extra*
	rm "${ED}"/usr/lib/pkgconfig/libfm-extra.pc
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
