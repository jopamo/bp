# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib-minimal meson git-r3

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://github.com/GNOME/at-spi2-atk.git"

LICENSE="LGPL-2+"
SLOT="2"
SONAME="2.27"
KEYWORDS="amd64 arm64 x86"

IUSE="dbus"

COMMON_DEPEND="
	>=gui-lib/at-spi2-core-2.17.90[${MULTILIB_USEDEP}]
	>=gui-lib/atk-2.15.4[${MULTILIB_USEDEP}]
	>=lib-dev/glib-2.32:2[${MULTILIB_USEDEP}]
	dbus? ( >=sys-app/dbus-1.5[${MULTILIB_USEDEP}] )
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/at-spi-1.32.0-r1
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig[${MULTILIB_USEDEP}]
"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
        local emesonargs=(
                -Ddisable_p2p=$(usex dbus false)
        )
        meson_src_configure
}
