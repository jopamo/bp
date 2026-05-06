# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Accessible sans-serif family optimized for legibility"
HOMEPAGE="https://github.com/googlefonts/atkinson-hyperlegible-next"
COMMIT="7925f50f649b3813257faf2f4c0b381011f434f1"
SRC_URI="https://github.com/googlefonts/atkinson-hyperlegible-next/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto "${FONTDIR}"
	doins fonts/ttf/*.ttf

	dodoc AUTHORS.txt CONTRIBUTORS.txt OFL.txt README.md
}
