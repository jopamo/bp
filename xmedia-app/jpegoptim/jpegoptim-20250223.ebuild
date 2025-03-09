# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility to optimize JPEG files"
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html https://github.com/tjko/jpegoptim"

SNAPSHOT=da1e0dd43661fbe800b860768af9ccd0e5617e6e
SRC_URI="https://github.com/tjko/jpegoptim/archive/${SNAPSHOT}.tar.gz -> jpegoptim-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jpegoptim-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xmedia-lib/libjpeg-turbo"
