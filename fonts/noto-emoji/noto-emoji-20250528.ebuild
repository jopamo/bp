# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Google's font family that aims to support all the world's languages"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/googlefonts/noto-fonts"

COMMIT="22e564626297b4df0a40570ad81d6c05cc7c38bd"
SRC_URI="https://github.com/googlefonts/noto-emoji/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/noto-emoji-${COMMIT}"

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
	rm Makefile
	default
}

pkg_postinst() {
	fc-cache -fv
}
