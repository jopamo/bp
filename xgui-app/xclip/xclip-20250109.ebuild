# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Copy data from standard input to X clipboard"
HOMEPAGE="https://github.com/astrand/xclip"

SNAPSHOT=2c3b811002b35d3be7f39cc1145dd06bdb32e31c
SRC_URI="https://github.com/astrand/xclip/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
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
	qa-policy-configure
	default
	eautoreconf
}

src_install() {
	default
	qa-policy-install
}
