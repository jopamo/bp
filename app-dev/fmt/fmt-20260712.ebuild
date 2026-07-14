# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A modern formatting library"
HOMEPAGE="https://github.com/fmtlib/fmt"
SNAPSHOT=a79df4504cd4e42ed004b1113fb82171e62ed822
SRC_URI="https://github.com/fmtlib/fmt/archive/${SNAPSHOT}.tar.gz -> fmt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fmt-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
