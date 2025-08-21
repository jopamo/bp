# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Unicode routines (UTF8, UTF16, UTF32) and Base64: billions of characters per second"
HOMEPAGE="https://github.com/simdutf/simdutf"
SNAPSHOT=0063f27b59d5064e673281347b363b89519a9148
SRC_URI="https://github.com/simdutf/simdutf/archive/${SNAPSHOT}.tar.gz -> simdutf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/simdutf-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
