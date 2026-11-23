# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A modern formatting library"
HOMEPAGE="https://github.com/fmtlib/fmt"
SNAPSHOT=14ac0d5a9d40aef14f50954069c1e10971abb0b2
SRC_URI="https://github.com/fmtlib/fmt/archive/${SNAPSHOT}.tar.gz -> fmt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fmt-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}/platform-locales.patch" )
