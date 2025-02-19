# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=014ed4ce881fc3154c08e98e8d59c1b13c3f2f06

inherit autotools flag-o-matic

DESCRIPTION="Library to create and utilize caches to speed up freedesktop application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="https://github.com/lxde/menu-cache/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	app-dev/gtk-doc
	lib-util/glib
	xgui-lib/libfm-extra
"

src_prepare() {
	append-flags -fcommon

	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
