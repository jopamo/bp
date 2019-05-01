# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font git-r3

DESCRIPTION="Monospaced font with programming ligatures"
HOMEPAGE="https://github.com/googlefonts/Inconsolata"
EGIT_REPO_URI="https://github.com/googlefonts/Inconsolata.git"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

FONT_S="${S}/fonts/otf"
FONT_SUFFIX="otf"
