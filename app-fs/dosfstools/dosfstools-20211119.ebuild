# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="https://github.com/dosfstools/dosfstools"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/dosfstools/dosfstools.git"
	inherit git-r3
else
	SNAPSHOT=fed19c29ae86060550e40bcb656b673ac6ba61bc
	SRC_URI="https://github.com/dosfstools/dosfstools/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	touch config.rpath || die
	default
	eautoreconf
}
