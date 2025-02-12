# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org X Display Manager Control Protocol library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=8f3408f3936bacd08f76d5ee22cbc86e6b627287
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXdmcp/-/archive/${SNAPSHOT}/libXdmcp-${SNAPSHOT}.tar.bz2 -> libXdmcp-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxdmcp-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	lib-dev/libbsd
	xgui-tools/xorgproto
	xgui-tools/util-macros"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-docs
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
