# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Security Scanner"
HOMEPAGE="https://github.com/github/codeql"
SNAPSHOT=b79f0a2cf2a7817aa2ff4cb64ae522e2d139e118
SRC_URI="https://github.com/github/codeql/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/codeql-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"


