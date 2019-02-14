# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://github.com/GNOME/at-spi2-atk.git"

LICENSE="LGPL-2+"
SLOT="2"
SONAME="2.27"
KEYWORDS="amd64 arm64"

IUSE="dbus"

COMMON_DEPEND="
	>=gui-lib/at-spi2-core-2.17.90
	>=gui-lib/atk-2.15.4
	>=lib-dev/glib-2.32:2
	dbus? ( >=sys-app/dbus-1.5 )
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/at-spi-1.32.0-r1
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
"

src_configure() {
        local emesonargs=(
                -Ddisable_p2p=$(usex dbus false)
        )
        meson_src_configure
}
