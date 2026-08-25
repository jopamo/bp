# Distributed under the terms of the GNU General Public License v2

inherit meson

PROPERTIES+=" source-payload"

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/XKeyboardConfig"
SNAPSHOT=582bb71b64c4a638a2aad63256b78508081c14e8
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
