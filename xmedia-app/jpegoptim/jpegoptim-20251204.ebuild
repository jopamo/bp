# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility to optimize JPEG files"
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html https://github.com/tjko/jpegoptim"
SNAPSHOT=15c0e3e6ee2d49d8ba9523dc8761b122b1f86ad9
SRC_URI="https://github.com/tjko/jpegoptim/archive/${SNAPSHOT}.tar.gz -> jpegoptim-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jpegoptim-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xmedia-lib/libjpeg-turbo"
