# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="hwdata files"
HOMEPAGE="https://github.com/vcrhonek/hwdata"
SNAPSHOT=d263c183dd429bbe1572a91a8cf180e84b8341c6
SRC_URI="https://github.com/vcrhonek/hwdata/archive/${SNAPSHOT}.tar.gz -> hwdata-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/hwdata-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
