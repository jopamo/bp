# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Modern audio compression for the internet"
HOMEPAGE="https://opus-codec.org/"

SNAPSHOT=2941f08a616290f291579df9c8dbc0801d8d3f18
SRC_URI="https://github.com/xiph/opus/archive/${SNAPSHOT}.tar.gz -> opus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/opus-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
