# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility to optimize JPEG files"
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html https://github.com/tjko/jpegoptim"

SNAPSHOT=bacfd518fc225f16240b5271dc9755516ada43fc
SRC_URI="https://github.com/tjko/jpegoptim/archive/${SNAPSHOT}.tar.gz -> jpegoptim-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jpegoptim-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xmedia-lib/libjpeg-turbo"
