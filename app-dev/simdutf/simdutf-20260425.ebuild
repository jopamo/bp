# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Unicode routines (UTF8, UTF16, UTF32) and Base64: billions of characters per second"
HOMEPAGE="https://github.com/simdutf/simdutf"
SNAPSHOT=427a6f525f5051d448f9337220211ec21332f542
SRC_URI="https://github.com/simdutf/simdutf/archive/${SNAPSHOT}.tar.gz -> simdutf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/simdutf-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
