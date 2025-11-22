# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="https://github.com/jopamo/libev"

SNAPSHOT=1b540ad14c21fdb9df64c4b3f43f087b2e017fbc
SRC_URI="https://github.com/jopamo/libev/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_install() {
	meson_src_install
	rm "${ED}"/usr/include/event.h
}
