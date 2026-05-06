# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Symbols-only Nerd Font icon fallback"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/NerdFontsSymbolsOnly.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto "${FONTDIR}"
	doins SymbolsNerdFont-*.ttf SymbolsNerdFontMono-*.ttf

	dodoc LICENSE README.md
}
