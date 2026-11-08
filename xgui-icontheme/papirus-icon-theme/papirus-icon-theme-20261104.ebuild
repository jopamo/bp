# Distributed under the terms of the GNU General Public License v2

inherit xdg

PROPERTIES+=" source-payload"

DESCRIPTION="Papirus icons theme"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme"
SNAPSHOT=f66c41b7859ecca2a79a2f26a28da481dc01a369
SRC_URI="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE=" || ( GPL3 LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/icons/
	doins -r Papirus*
}
