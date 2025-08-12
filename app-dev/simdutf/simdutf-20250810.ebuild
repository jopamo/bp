# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Unicode routines (UTF8, UTF16, UTF32) and Base64: billions of characters per second"
HOMEPAGE="https://github.com/simdutf/simdutf"
SNAPSHOT=ae3655a972207ea84dd756418a973034c46958ee
SRC_URI="https://github.com/simdutf/simdutf/archive/${SNAPSHOT}.tar.gz -> simdutf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/simdutf-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
