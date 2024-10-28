# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Copy data from standard input to X clipboard"
HOMEPAGE="https://github.com/astrand/xclip"
SRC_URI="https://github.com/astrand/xclip/archive/${PV}.tar.gz -> ${P}.tar.gz"

SNAPSHOT=b372f73579d30f9ba998ffd0a73694e7abe2c313
SRC_URI="https://github.com/astrand/xclip/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/xclip-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libXmu
"
DEPEND="
	${RDEPEND}
	xgui-tools/xorgproto
	xgui-lib/libXt
"

src_prepare() {
	default
	eautoreconf
}
