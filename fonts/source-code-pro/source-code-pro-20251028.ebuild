# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Monospaced font family"
HOMEPAGE="https://github.com/adobe-fonts/source-code-pro"
SNAPSHOT=803b7e23ec97ae58b6232ea76519a76d428ba268
SRC_URI="https://github.com/adobe-fonts/source-code-pro/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

FONT_S="${S}/TTF"
FONT_SUFFIX="ttf"

src_prepare() {
	rm Makefile Dockerfile
	default
}

pkg_postinst() {
	fc-cache -fv
}

