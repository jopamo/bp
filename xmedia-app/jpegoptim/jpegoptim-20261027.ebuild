# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Utility to optimize JPEG files"
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html https://github.com/tjko/jpegoptim"
SNAPSHOT=91be8033ef5fb9ee23700d5c98d5023eebd6046c
SRC_URI="https://github.com/tjko/jpegoptim/archive/${SNAPSHOT}.tar.gz -> jpegoptim-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jpegoptim-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xmedia-lib/libjpeg-turbo"
