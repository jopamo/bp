# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="hwdata files"
HOMEPAGE="https://github.com/vcrhonek/hwdata"

SNAPSHOT=736513dfc1d44c5fb48bead62af7e91c4e1d1dd2
SRC_URI="https://github.com/vcrhonek/hwdata/archive/${SNAPSHOT}.tar.gz -> hwdata-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/hwdata-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
