# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="D-Bus bindings for glib"
HOMEPAGE="https://dbus.freedesktop.org/"
EGIT_REPO_URI="https://github.com/freedesktop/dbus-glib.git"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs test"

DEPEND="
	lib-core/expat
	lib-live/glib
	app-core/dbus
"

BDEPEND="
	app-dev/gtk-doc
	app-dev/pkgconf
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
