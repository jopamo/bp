# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="BLAS, CBLAS, LAPACK, LAPACKE reference implementations"
HOMEPAGE="https://www.netlib.org/lapack/"

SNAPSHOT=48677eea06845cf7d53c61ca9f6a8b958bbb97b6
SRC_URI="https://github.com/Reference-LAPACK/lapack/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MPL-2.0"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"
