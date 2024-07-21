# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="https://wiki.gnome.org/Accessibility"

SNAPSHOT=16ac41c334ad101ec4db81844d85bf0e5e4e37bf
SRC_URI="https://gitlab.gnome.org/GNOME/at-spi2-core/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

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

	cat > "${T}"/99${PN} <<- EOF || die
		NO_AT_BRIDGE=1
	EOF
	doenvd "${T}"/99${PN}
}
