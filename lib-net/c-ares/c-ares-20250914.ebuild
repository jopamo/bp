# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C library that resolves names asynchronously"
HOMEPAGE="https://c-ares.haxx.se/"

#SRC_URI="https://github.com/c-ares/c-ares/releases/download/v${PV}/${PN}-${SNAPSHOT}.tar.gz"
SNAPSHOT=89f91c07436c5d18926f8b2ff3d078787c1c5fe2
SRC_URI="https://github.com/c-ares/c-ares/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/c-ares-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
