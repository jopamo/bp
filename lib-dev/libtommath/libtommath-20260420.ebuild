# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="portable number theoretic multiple-precision integer library"
HOMEPAGE="https://github.com/libtom/libtommath"

SNAPSHOT=ae40a87a920099a7d9d00979570e0c8d917a1fd7
SRC_URI="https://github.com/libtom/libtommath/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"
