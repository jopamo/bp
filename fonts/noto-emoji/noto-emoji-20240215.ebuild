# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Google's font family that aims to support all the world's languages"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/googlefonts/noto-fonts"

SNAPSHOT=41e31b110b4eb929dffb410264694a06205b7ad7
SRC_URI="https://github.com/googlefonts/noto-emoji/archive/${SNAPSHOT}.tar.gz -> noto-emoji-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/noto-emoji-${SNAPSHOT}"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/googlefonts/noto-emoji"
	inherit
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=41e31b110b4eb929dffb410264694a06205b7ad7
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
	"${FILESDIR}/66-emoji.conf"
)

src_prepare() {
	rm Makefile fonts/NotoColorEmoji_WindowsCompatible.ttf
	default
}

pkg_postinst() {
	fc-cache -fv
}
