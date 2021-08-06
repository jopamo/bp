# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font git-r3

DESCRIPTION="Monospaced font with programming ligatures"
HOMEPAGE="https://github.com/tonsky/FiraCode"
EGIT_REPO_URI="https://github.com/tonsky/FiraCode.git"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

FONT_S="${S}/distr/ttf"
FONT_SUFFIX="ttf"

src_prepare() {
	rm Makefile Dockerfile
	default
}
