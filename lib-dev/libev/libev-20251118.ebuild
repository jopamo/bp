# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="http://software.schmorp.de/pkg/libev.html"

SNAPSHOT=110f1cffa79939d63e5df341e51ce3ab0d389081
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
