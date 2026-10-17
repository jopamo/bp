# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Unicode routines (UTF8, UTF16, UTF32) and Base64: billions of characters per second"
HOMEPAGE="https://github.com/simdutf/simdutf"
SNAPSHOT=b46e4aaa294639c1c1566a7867087171526e3661
SRC_URI="https://github.com/simdutf/simdutf/archive/${SNAPSHOT}.tar.gz -> simdutf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/simdutf-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
