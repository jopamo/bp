# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font git-r3

DESCRIPTION="Google's font family that aims to support all the world's languages"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/googlefonts/noto-fonts"
EGIT_REPO_URI="https://github.com/jopamo/micronoto.git"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

FONT_SUFFIX="ttf"

src_install() {
	FONT_S="${S}/unhinted/" font_src_install
	FONT_S="${S}/hinted/" font_src_install
	FONT_S="${S}/roboto/" font_src_install
}

pkg_postinst() {
	fc-cache -fv
}
