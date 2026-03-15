# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Keyboard map conversion database used by QEMU"
HOMEPAGE="https://gitlab.com/qemu-project/keycodemapdb"
SNAPSHOT=f5772a62ec52591ff6870b7e8ef32482371f22c6
SRC_URI="https://gitlab.com/qemu-project/keycodemapdb/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	dodir /usr/share/${PN}
	cp -a . "${ED}"/usr/share/${PN}/ || die
}
