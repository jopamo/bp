# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Microsoft Cascadia developer fonts"
HOMEPAGE="https://github.com/microsoft/cascadia-code"
SRC_URI="https://github.com/microsoft/cascadia-code/releases/download/v${PV}/CascadiaCode-${PV}.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto "${FONTDIR}"
	doins ttf/static/CascadiaCode-*.ttf ttf/static/CascadiaMono-*.ttf
}
