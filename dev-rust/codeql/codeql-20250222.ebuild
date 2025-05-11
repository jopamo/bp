# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Security Scanner"
HOMEPAGE="https://github.com/github/codeql"

SNAPSHOT=a857069345f1d093933ea0e12e8c228810a2b2d8
SRC_URI="https://github.com/github/codeql/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"


