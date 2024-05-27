# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dracula gtk theme"
HOMEPAGE="https://github.com/dracula/gtk"

SNAPSHOT=9261309c75b49c0917b4787912f6218b8deba70d
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
