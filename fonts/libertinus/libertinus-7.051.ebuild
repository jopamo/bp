# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Libertinus serif family"
HOMEPAGE="https://github.com/alerque/libertinus"
SRC_URI="https://github.com/alerque/libertinus/releases/download/v${PV}/Libertinus-${PV}.zip -> ${P}.zip"
S="${WORKDIR}/Libertinus-${PV}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto "${FONTDIR}"
	doins static/TTF/LibertinusSerif-*.ttf

	dodoc AUTHORS.txt CONTRIBUTORS.txt FONTLOG.txt OFL.txt README.md
}
