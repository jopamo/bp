# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Inter font family for computer screens"
HOMEPAGE="https://github.com/rsms/inter"
SRC_URI="https://github.com/rsms/inter/releases/download/v${PV}/Inter-${PV}.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto "${FONTDIR}"
	doins extras/ttf/Inter-*.ttf

	dodoc LICENSE.txt
}
