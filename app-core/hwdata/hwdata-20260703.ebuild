# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="hwdata files"
HOMEPAGE="https://github.com/vcrhonek/hwdata"
SNAPSHOT=d1f69718374423ae9443a44c890e4e2044f1f2b2
SRC_URI="https://github.com/vcrhonek/hwdata/archive/${SNAPSHOT}.tar.gz -> hwdata-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/hwdata-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_test() {
	NO_DOCKER=1 emake check
}
