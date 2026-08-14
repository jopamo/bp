# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="D-Bus bindings for glib"
HOMEPAGE="https://dbus.freedesktop.org/"

SNAPSHOT=6c42458fc17e2e218d9a9c3dcc69223795c85aa5
SRC_URI="https://gitlab.freedesktop.org/dbus/dbus-glib/-/archive/${SNAPSHOT}/dbus-glib-${SNAPSHOT}.tar.bz2 -> dbus-glib-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/dbus-glib-${SNAPSHOT}"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs test"

DEPEND="
	lib-core/expat
	lib-core/glib
	virtual/dbus
"

BDEPEND="
	app-dev/gtk-doc
	app-dev/pkgconf
"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}"/var
		--disable-gtk-doc
		$(use_enable debug asserts)
		$(use_enable static-libs static)
		$(use_enable test tests)
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
