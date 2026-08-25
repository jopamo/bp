# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="hwdata files"
HOMEPAGE="https://github.com/vcrhonek/hwdata"
SNAPSHOT=8bb6c48dc2e683777e625d1c9ef02c1b25b741cd
SRC_URI="https://github.com/vcrhonek/hwdata/archive/${SNAPSHOT}.tar.gz -> hwdata-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/hwdata-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_test() {
	NO_DOCKER=1 emake check
}
