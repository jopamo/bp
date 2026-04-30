# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms"
HOMEPAGE="https://gitlab.com/libeigen/eigen"

SNAPSHOT=bc3b39870ecb690a623a3f49149a358b95c5781d
SRC_URI="https://gitlab.com/libeigen/eigen/-/archive/${SNAPSHOT}/eigen-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/eigen-${SNAPSHOT}"

LICENSE="MPL-2.0"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"
