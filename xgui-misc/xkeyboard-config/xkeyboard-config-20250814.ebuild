# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/XKeyboardConfig"

SNAPSHOT=af35af06c99be2e0d8bcf6889650d7e1b5d6cf64
SRC_URI="https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/archive/${SNAPSHOT}/xkeyboard-config-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-build/gettext
	app-dev/intltool
"

src_configure() {
	local emesonargs=(
		-D compat-rules=true
		-D xorg-rules-symlinks=true
	)
		meson_src_configure
}
