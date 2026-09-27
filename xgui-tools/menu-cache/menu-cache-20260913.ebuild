# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=11bc3d4c66faab16f10c6071f6a0923d922e7652

inherit autotools flag-o-matic qa-policy

DESCRIPTION="Library to create and utilize caches to speed up freedesktop application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="https://github.com/lxde/menu-cache/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/menu-cache-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	app-dev/gtk-doc
	lib-core/glib
	xgui-lib/libfm-extra
"

src_prepare() {
	append-flags -fcommon

	default
	eautoreconf
}

src_configure() {
	qa-policy-configure
	default
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
