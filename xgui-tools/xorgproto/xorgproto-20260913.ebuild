# Distributed under the terms of the GNU General Public License v2

inherit meson

PROPERTIES+=" source-payload"

DESCRIPTION="X.Org combined protocol headers"
HOMEPAGE="https://www.x.org"
SNAPSHOT=fd86fbff46eb7ab8e193c12b8a529e90bae31835
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
