# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="A library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
EGIT_REPO_URI="https://github.com/lxde/libfm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/glib
	app-compression/xz-utils
	>=dev-util/intltool-0.40
	dev-util/pkgconf
	sys-devel/gettext
	dev-util/gtk-doc
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
		--disable-udisks
		--without-gtk
		--with-html-dir=/usr/share/doc/${PF}/html
		--disable-old-actions
		--with-extra-only
	)
	econf ${myconf[@]}
}
