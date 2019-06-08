# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg-utils

DESCRIPTION="Feature rich terminal emulator using the Enlightenment Foundation Libraries"
HOMEPAGE="https://www.enlightenment.org/about-terminology"
SRC_URI="https://download.enlightenment.org/rel/apps/${PN}/${P}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="extras nls"

RDEPEND="
	|| ( lib-dev/efl[gles2] lib-dev/efl[opengl] )
	|| ( lib-dev/efl[X] lib-dev/efl[wayland] )
	lib-dev/efl[eet,fontconfig]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/pkgconf
	nls? ( sys-devel/gettext )
"

src_configure() {
	local emesonargs=(
		$(meson_use nls)
		$(meson_use extras tests)
	)

	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
