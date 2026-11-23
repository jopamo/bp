# Distributed under the terms of the GNU General Public License v2

inherit xdg

PROPERTIES+=" source-payload"

DESCRIPTION="Papirus icons theme"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme"
SNAPSHOT=626182cfe885b7eb2dbb7bcae5cde6d8d1048f2f
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
