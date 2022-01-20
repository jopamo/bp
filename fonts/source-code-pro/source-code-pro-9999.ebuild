# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Monospaced font family"
HOMEPAGE="https://github.com/adobe-fonts/source-code-pro"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="${HOMEPAGE}"
	inherit git-r3
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=f1f97679985487deaa1f7f178f36f4a1a7910154
	SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

FONT_S="${S}/TTF"
FONT_SUFFIX="ttf"

src_prepare() {
	rm Makefile Dockerfile
	default
}
