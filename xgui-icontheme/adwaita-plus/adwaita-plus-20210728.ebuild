# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="icons theme based on GNOME 3.32's Adwaita"
HOMEPAGE="https://github.com/Bonandry/adwaita-plus.git"

SNAPSHOT=8dd6ce97826c7b947e8e6dc023ae8a5c1b9429dd
SRC_URI="https://github.com/Bonandry/adwaita-plus/archive/${SNAPSHOT}.tar.gz -> adwaita-plus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/adwaita-plus-${SNAPSHOT}"

LICENSE=" || ( GPL3 LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/icons/
	doins -r Adwaita*
}
