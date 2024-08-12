# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Modern audio compression for the internet"
HOMEPAGE="https://opus-codec.org/"

SNAPSHOT=5854a9f7de06ab3505b8fe6e8943db581c2cbe70
SRC_URI="https://github.com/xiph/opus/archive/${SNAPSHOT}.tar.gz -> opus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/opus-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
