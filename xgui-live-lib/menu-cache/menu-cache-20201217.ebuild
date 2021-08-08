# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=583c1901719f2ef2aa3aa0034bd370983a7ed523

inherit autotools flag-o-matic

DESCRIPTION="Library to create and utilize caches to speed up freedesktop application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="https://github.com/lxde/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0/2"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="lib-live/glib:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconf
	xgui-live-lib/libfm-extra
	dev-util/gtk-doc"

append-flags -fcommon

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
