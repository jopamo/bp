# Distributed under the terms of the GNU General Public License v2

inherit cargo

DESCRIPTION="Security Scanner"
HOMEPAGE="https://github.com/github/codeql"
SNAPSHOT=2d76b41293134e9ab50307085214a7a1415e1713
SRC_URI="https://github.com/github/codeql/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/codeql-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"


