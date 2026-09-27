# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Modern audio compression for the internet"
HOMEPAGE="https://opus-codec.org/"
SNAPSHOT=503d81b138d76621aae4b12786e90de48aa8db3a
SRC_URI="https://github.com/xiph/opus/archive/${SNAPSHOT}.tar.gz -> opus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/opus-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
