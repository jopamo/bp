# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Monospaced font with programming ligatures"
HOMEPAGE="https://github.com/tonsky/FiraCode"
EGIT_REPO_URI="https://github.com/tonsky/FiraCode.git"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tonsky/FiraCode.git"
	inherit git-r3
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=34cced2a1235e2035fb1f258f228b0ed584b8911
	SRC_URI="https://github.com/tonsky/FiraCode/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/FiraCode-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://github.com/tonsky/FiraCode/releases/download/${PV}/Fira_Code_v${PV}.zip"
	S=${WORKDIR}/${P}-stable
fi

LICENSE="OFL-1.1"
SLOT="0"

FONT_S="${S}/distr/ttf"
FONT_SUFFIX="ttf"

src_prepare() {
	rm Makefile Dockerfile
	default
}
