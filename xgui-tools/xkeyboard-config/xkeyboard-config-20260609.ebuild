# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/XKeyboardConfig"
SNAPSHOT=7c0159cdacf048f437bb74436e134e62a7e2bcf0
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
