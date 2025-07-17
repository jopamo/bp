# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A modern formatting library"
HOMEPAGE="https://github.com/fmtlib/fmt"
SNAPSHOT=553ec11ec06fbe0beebfbb45f9dc3c9eabd83d28
SRC_URI="https://github.com/fmtlib/fmt/archive/${SNAPSHOT}.tar.gz -> fmt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fmt-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"
