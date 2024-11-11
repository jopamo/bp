# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dracula gtk theme"
HOMEPAGE="https://github.com/dracula/gtk"

SNAPSHOT=7803795e4dc727f4cf62549dc0c7ae1b4647f622
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
