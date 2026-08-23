# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Terminal-optimized Iosevka family"
HOMEPAGE="https://github.com/be5invis/Iosevka"
SRC_URI="https://github.com/be5invis/Iosevka/releases/download/v${PV}/PkgTTF-IosevkaTerm-${PV}.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto "${FONTDIR}"

	local font
	for font in IosevkaTerm-*.ttf; do
		[[ ${font} == IosevkaTerm-Extended* ]] && continue
		doins "${font}"
	done
}
