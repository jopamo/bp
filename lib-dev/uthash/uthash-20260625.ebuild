# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="An easy-to-use hash implementation for C programmers"
HOMEPAGE="https://troydhanson.github.io/uthash/index.html"
SNAPSHOT=a49bed0b4abb7dff16c73906dcdc8a9718d582d2
SRC_URI="https://github.com/troydhanson/uthash/archive/${SNAPSHOT}.tar.gz -> uthash-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/uthash-${SNAPSHOT}"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	doheader src/*.h
}
