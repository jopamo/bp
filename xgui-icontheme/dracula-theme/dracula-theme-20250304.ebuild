# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dracula gtk theme"
HOMEPAGE="https://github.com/dracula/gtk"

SNAPSHOT=285ff8f10084b5fdae045a8e8d09352be9af4452
SRC_URI="https://github.com/dracula/gtk/archive/${SNAPSHOT}.tar.gz -> gtk-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gtk-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	rm -r kde || die
	insinto /usr/share/themes/dracula
	doins -r .
}
