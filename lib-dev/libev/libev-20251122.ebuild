# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="https://github.com/jopamo/libev"

SNAPSHOT=e2fa7d5f23edaea81f1ce1e67db9f0d752e083a1
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
