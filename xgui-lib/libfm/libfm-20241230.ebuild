# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="A library for file management"
HOMEPAGE="https://github.com/lxde/${PN}"

SNAPSHOT=af3e5c0fc5bdecf146f32c35936797ae0b9af6e7
SRC_URI="https://github.com/lxde/libfm/archive/${SNAPSHOT}.tar.gz -> libfm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libfm-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +exif"

DEPEND="
	lib-util/glib
	xgui-lib/gtk3
	xgui-misc/menu-cache
	xgui-misc/shared-mime-info
	exif? ( xmedia-lib/libexif )
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
