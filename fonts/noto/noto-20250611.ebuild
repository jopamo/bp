# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Google's font family that aims to support all the world's languages"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/googlefonts/noto-fonts"

COMMIT="b960707560f8aa197a947a3f46c0b4c7f7e44804"
SRC_URI="https://github.com/notofonts/notofonts.github.io/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/notofonts.github.io-${COMMIT}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

FONT_SUFFIX="ttf"

src_install() {
    mkdir install-hinted || die

    for subdir in NotoSans NotoSansMath NotoSerif NotoSansMono NotoSansSymbols NotoSansSymbols2; do
        if [ -d "fonts/${subdir}/hinted/ttf" ]; then
            mv "fonts/${subdir}/hinted/ttf"/*.tt[fc] install-hinted/ || die
        fi
    done

    FONT_S="${S}/install-hinted/" font_src_install
}

pkg_postinst() {
	fc-cache -fv
}
