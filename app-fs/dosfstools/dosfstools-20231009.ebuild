# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="https://github.com/dosfstools/dosfstools"

SNAPSHOT=289a48b9cb5b3c589391d28aa2515c325c932c7a
SRC_URI="https://github.com/dosfstools/dosfstools/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dosfstools-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	touch config.rpath || die
	default
	eautoreconf
}
