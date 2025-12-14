# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms"
HOMEPAGE="https://gitlab.com/libeigen/eigen"

SNAPSHOT=a9110bfc876b00f0cfcb4ef0980ea4125578f057
SRC_URI="https://gitlab.com/libeigen/eigen/-/archive/${SNAPSHOT}/eigen-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/eigen-${SNAPSHOT}"

LICENSE="MPL-2.0"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"
