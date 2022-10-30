# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Google's font family that aims to support all the world's languages"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/googlefonts/noto-fonts"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/googlefonts/noto-emoji.git"
	inherit git-r3
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=""
	SRC_URI="https://github.com/googlefonts/noto-emoji/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/noto-emoji-${SNAPSHOT}
else
	SRC_URI="https://github.com/googlefonts/noto-emoji/releases/download/${PV}/Fira_Code_v${PV}.zip"
	S=${WORKDIR}/${P}-stable
fi


LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

FONT_S="${S}/fonts"
FONT_SUFFIX="ttf"
FONT_CONF=(
	"${FILESDIR}/66-noto-color-emoji.conf"
)

src_prepare() {
	rm Makefile fonts/{Noto-COLR*,NotoColorEmoji_WindowsCompatible.ttf}
	default
}
