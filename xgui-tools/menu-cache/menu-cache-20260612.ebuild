# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=cd6f68470a86a6381d45680a71b95c30876180a9

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
