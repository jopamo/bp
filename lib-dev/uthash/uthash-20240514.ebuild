# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An easy-to-use hash implementation for C programmers"
HOMEPAGE="https://troydhanson.github.io/uthash/index.html"

SNAPSHOT=619fe95ca4679249528f086536aadd0c469dbd99
SRC_URI="https://github.com/troydhanson/uthash/archive/${SNAPSHOT}.tar.gz -> uthash-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/uthash-${SNAPSHOT}"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	doheader src/*.h
}
