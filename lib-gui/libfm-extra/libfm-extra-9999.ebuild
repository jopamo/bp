# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="A library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
EGIT_REPO_URI="https://github.com/lxde/libfm.git"

KEYWORDS="amd64 arm64"
LICENSE="GPL-2"
SLOT="0/4.5.0" #copy ABI_VERSION because it seems upstream change it randomly

RDEPEND=">=lib-dev/glib-2.18:2"
DEPEND="${RDEPEND}
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
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
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
