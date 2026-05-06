# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Developer-focused monospace family"
HOMEPAGE="https://github.com/JetBrains/JetBrainsMono"
SRC_URI="https://github.com/JetBrains/JetBrainsMono/releases/download/v${PV}/JetBrainsMono-${PV}.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_unpack() {
	# This archive omits a top-level "fonts/" entry but contains nested
	# directories under it. The unzip used by unpack() chokes unless the
	# parent exists first.
	mkdir -p "${WORKDIR}/fonts" || die
	default
}

src_install() {
	insinto "${FONTDIR}"
	doins fonts/ttf/JetBrainsMono-*.ttf

	dodoc AUTHORS.txt OFL.txt
}
