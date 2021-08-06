# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 xdg-utils

DESCRIPTION="A library for file management"
HOMEPAGE="https://github.com/lxde/libfm"
EGIT_REPO_URI="https://github.com/lxde/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug doc exif"

COMMON_DEPEND=">=lib-dev/glib-2.18:2
	>=xgui-live-lib/menu-cache-0.3.2:=
"
RDEPEND="${COMMON_DEPEND}
	x11-live-misc/shared-mime-info
	exif? ( lib-media/libexif )"
DEPEND="${COMMON_DEPEND}
	doc? (
		dev-util/gtk-doc
	)
	>=dev-util/intltool-0.40
	dev-util/pkgconf
	sys-devel/gettext"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-dependency-tracking
		--disable-static
		--disable-demo
		$(use_enable exif)
		$(use_enable debug)
		--disable-udisks
		--without-gtk
		$(use_enable doc gtk-doc)
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
