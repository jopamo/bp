# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Google's font family that aims to support all the world's languages"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/googlefonts/noto-fonts"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/googlefonts/noto-fonts.git"
	inherit git-r3
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=""
	SRC_URI="https://github.com/googlefonts/noto-fonts/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/noto-fonts-${SNAPSHOT}
else
	SRC_URI="https://github.com/googlefonts/noto-fonts/releases/download/${PV}/Fira_Code_v${PV}.zip"
	S=${WORKDIR}/${P}-stable
fi


LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

FONT_SUFFIX="ttf"
FONT_CONF=(
	"${FILESDIR}/66-noto-mono.conf"
)

src_install() {
	mkdir install-unhinted install-hinted || die
	mv unhinted/ttf/NotoSansMono*/*.tt[fc] install-unhinted/. ||  die
	mv hinted/ttf/NotoSansMono*/*.tt[fc] install-hinted/. || die

	FONT_S="${S}/install-unhinted/" font_src_install
	FONT_S="${S}/install-hinted/" font_src_install

	rm -rf "${ED}"/usr/share/fonts/noto/Noto*{Condensed,SemiBold,Extra}*.ttf
}
