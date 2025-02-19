# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dracula gtk theme"
HOMEPAGE="https://github.com/dracula/gtk"

SNAPSHOT=fbc19694354e918f2a0df4a10b02f2127f69c441
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
