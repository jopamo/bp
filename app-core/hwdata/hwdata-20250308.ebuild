# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="hwdata files"
HOMEPAGE="https://github.com/vcrhonek/hwdata"

SNAPSHOT=fa1ccf4e4944bdb4110025c5c40e4fee8c8de29b
SRC_URI="https://github.com/vcrhonek/hwdata/archive/${SNAPSHOT}.tar.gz -> hwdata-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
