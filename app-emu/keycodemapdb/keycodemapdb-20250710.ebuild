# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Keyboard map conversion database used by QEMU"
HOMEPAGE="https://gitlab.com/qemu-project/keycodemapdb"
SNAPSHOT=54788039c0b3486a8883090d6736c2500177af29
SRC_URI="https://gitlab.com/qemu-project/keycodemapdb/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	dodir /usr/share/${PN}
	cp -a . "${ED}"/usr/share/${PN}/ || die
}
