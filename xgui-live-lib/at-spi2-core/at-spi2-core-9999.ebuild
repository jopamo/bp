# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/at-spi2-core.git"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/glib
	app-live/dbus-broker
"

BDEPEND="
	dev-util/gtk-doc-am
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconf
"

src_configure() {
        local emesonargs=(
			-Ddefault_bus=dbus-broker
        )
        meson_src_configure
}
