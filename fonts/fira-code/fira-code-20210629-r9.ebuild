# Distributed under the terms of the GNU General Public License v2

inherit font

DESCRIPTION="Monospaced font with programming ligatures"
HOMEPAGE="https://github.com/tonsky/FiraCode"
SNAPSHOT=f1f97679985487deaa1f7f178f36f4a1a7910154
SRC_URI="https://github.com/tonsky/FiraCode/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/FiraCode-${SNAPSHOT}
KEYWORDS="amd64 arm64"

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
