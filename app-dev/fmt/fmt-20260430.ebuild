# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A modern formatting library"
HOMEPAGE="https://github.com/fmtlib/fmt"
SNAPSHOT=8f20ee6191a8b1b00ff387e484b751d8abeb3ef8
SRC_URI="https://github.com/fmtlib/fmt/archive/${SNAPSHOT}.tar.gz -> fmt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fmt-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
