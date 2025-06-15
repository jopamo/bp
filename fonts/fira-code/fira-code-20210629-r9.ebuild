# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Monospaced font with programming ligatures"
HOMEPAGE="https://github.com/tonsky/FiraCode"
EGIT_REPO_URI="https://github.com/tonsky/FiraCode"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tonsky/FiraCode"
	inherit
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=f1f97679985487deaa1f7f178f36f4a1a7910154
	SRC_URI="https://github.com/tonsky/FiraCode/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
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

pkg_postinst() {
	fc-cache -fv
}

