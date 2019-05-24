# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="D-Bus bindings for glib"
HOMEPAGE="https://dbus.freedesktop.org/"
EGIT_REPO_URI="https://github.com/freedesktop/dbus-glib.git"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug static-libs test"

CDEPEND="
	>=lib-dev/expat-2.1.0-r3
	>=lib-dev/glib-2.34.3:2
	>=sys-app/dbus-1.8
"
DEPEND="${CDEPEND}
	>=dev-util/gtk-doc-am-1.14
	dev-util/pkgconf
"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}"/var
		--disable-gtk-doc
		$(use_enable debug asserts)
		$(use_enable static-libs static)
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
