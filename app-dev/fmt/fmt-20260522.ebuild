# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A modern formatting library"
HOMEPAGE="https://github.com/fmtlib/fmt"
SNAPSHOT=93e26fa578712891ee0a5302e7563e0ba79efef9
SRC_URI="https://github.com/fmtlib/fmt/archive/${SNAPSHOT}.tar.gz -> fmt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fmt-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
