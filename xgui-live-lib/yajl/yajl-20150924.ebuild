# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION=" A fast streaming JSON parsing library in C. "
HOMEPAGE="https://github.com/lloyd/yajl"

SNAPSHOT=5e3a7856e643b4d6410ddc3f84bc2f38174f2872
SRC_URI="https://github.com/lloyd/yajl/archive/${SNAPSHOT}.tar.gz -> yajl-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/yajl-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"
