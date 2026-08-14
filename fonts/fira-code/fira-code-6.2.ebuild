# Distributed under the terms of the GNU General Public License v2

inherit font qa-policy

DESCRIPTION="Monospaced font with programming ligatures"
HOMEPAGE="https://github.com/tonsky/FiraCode"
SRC_URI="https://github.com/tonsky/FiraCode/releases/download/${PV}/Fira_Code_v${PV}.zip"
S="${WORKDIR}"
KEYWORDS="amd64 arm64"

LICENSE="OFL-1.1"
SLOT="0"

FONT_S="${S}/ttf"
FONT_SUFFIX="ttf"

src_configure() {
	qa-policy-configure
}

src_install() {
	font_src_install
	qa-policy-install
}
