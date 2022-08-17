# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg

DESCRIPTION="icons theme based on GNOME 3.32's Adwaita"
HOMEPAGE="https://github.com/Bonandry/adwaita-plus.git"
EGIT_REPO_URI="https://github.com/Bonandry/adwaita-plus.git"

LICENSE=" || ( GPL3 LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/icons/
	doins -r Adwaita*
}
