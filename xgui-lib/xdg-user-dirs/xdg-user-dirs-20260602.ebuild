# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="a tool to help manage well known user directories"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-user-dirs/"
SNAPSHOT=15e94fbf7a6e62bc788c6309c50d3ea376f8b491
SRC_URI="https://gitlab.freedesktop.org/xdg/xdg-user-dirs/-/archive/${SNAPSHOT}/xdg-user-dirs-${SNAPSHOT}.tar.bz2 -> xdg-user-dirs-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xdg-user-dirs-${SNAPSHOT}"

LICENSE="GPL-2+ MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-tex/docbookz
	lib-core/libxslt
"

src_configure() {
	local emesonargs=(
		-Ddocs=true
		-Dnls=false
	)

	meson_src_configure
}
