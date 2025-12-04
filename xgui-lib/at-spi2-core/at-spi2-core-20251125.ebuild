# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
SNAPSHOT=9ace8dc0f0b5aac85d2486da89ccd63a496a92ab
SRC_URI="https://gitlab.gnome.org/GNOME/at-spi2-core/-/archive/${SNAPSHOT}/at-spi2-core-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/at-spi2-core-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/dbus
	lib-util/glib
"
BDEPEND="
	app-build/gettext
	app-dev/gtk-doc-am
	app-dev/intltool
	app-dev/pkgconf
"

src_install() {
	meson_src_install

	cat > "${T}"/99at-spi2-core <<- EOF || die
		NO_AT_BRIDGE=1
	EOF
	doenvd "${T}"/99at-spi2-core

	rm -rf "${ED}"/etc/xdg/autostart
	rm "${ED}"/usr/share/dbus-1/services/org.a11y.Bus.service || die
	rm "${ED}"/usr/share/dbus-1/accessibility-services/org.a11y.atspi.Registry.service || die

}
