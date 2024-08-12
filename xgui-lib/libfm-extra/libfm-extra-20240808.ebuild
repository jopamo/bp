# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"

SNAPSHOT=1c76b8fca4ef5fc4f176ae9a2f7f86ca9451a10f
SRC_URI="https://github.com/lxde/libfm/archive/${SNAPSHOT}.tar.gz -> libfm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libfm-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-util/glib
	app-compression/xz-utils
	>=app-dev/intltool-0.40
	app-dev/pkgconf
	app-build/gettext
	app-dev/gtk-doc
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
