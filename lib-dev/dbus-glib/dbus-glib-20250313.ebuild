# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="D-Bus bindings for glib"
HOMEPAGE="https://dbus.freedesktop.org/"

SNAPSHOT=8c1e96ffcbf4f5d8fb576224ca3abda052131013
SRC_URI="https://gitlab.freedesktop.org/dbus/dbus-glib/-/archive/${SNAPSHOT}/dbus-glib-${SNAPSHOT}.tar.bz2 -> dbus-glib-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/dbus-glib-${SNAPSHOT}"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs test"

DEPEND="
	lib-core/expat
	lib-util/glib
	app-core/dbus
"

BDEPEND="
	app-dev/gtk-doc
	app-dev/pkgconf
"

src_prepare() {
	default
	eautoreconf
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
