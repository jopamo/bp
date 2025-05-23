# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X.Org combined protocol headers"
HOMEPAGE="https://www.x.org"

SNAPSHOT=1914233e662d23ffb3812b80fadd0bbd064ad91c
SRC_URI="https://gitlab.freedesktop.org/xorg/proto/xorgproto/-/archive/${SNAPSHOT}/xorgproto-${SNAPSHOT}.tar.bz2 -> xorgproto-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xorgproto-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/libxml2"

src_install() {
	meson_src_install

	insinto usr/include/X11/extensions
	doins include/X11/extensions/XKBgeom.h
}
