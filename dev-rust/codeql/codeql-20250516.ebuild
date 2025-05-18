# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Security Scanner"
HOMEPAGE="https://github.com/github/codeql"

SNAPSHOT=d7e07b0b2dee20149cfe7ae84dd423d66948f5f1
SRC_URI="https://github.com/github/codeql/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"


