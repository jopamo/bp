# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="portable number theoretic multiple-precision integer library"
HOMEPAGE="https://github.com/libtom/libtommath"

SNAPSHOT=839ae9ea66718705fba2b5773d1bdfb2b457cea4
SRC_URI="https://github.com/libtom/libtommath/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"
