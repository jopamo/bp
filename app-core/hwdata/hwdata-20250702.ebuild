# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="hwdata files"
HOMEPAGE="https://github.com/vcrhonek/hwdata"
SNAPSHOT=e4423c783ca7db5c9d6d4881985272849f4892cf
SRC_URI="https://github.com/vcrhonek/hwdata/archive/${SNAPSHOT}.tar.gz -> hwdata-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/hwdata-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
