# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/at-spi2-atk.git"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dbus"

DEPEND="
	lib-gui/at-spi2-core
	lib-gui/atk
	lib-dev/glib
	dbus? ( sys-app/dbus )
"

src_configure() {
        local emesonargs=(
                -Ddisable_p2p=$(usex dbus false)
        )
        meson_src_configure
}
