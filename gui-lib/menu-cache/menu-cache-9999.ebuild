# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Library to create and utilize caches to speed up freedesktop application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
EGIT_REPO_URI="https://github.com/lxde/${PN}.git"

LICENSE="GPL-2"
SLOT="0/2"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="lib-dev/glib:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconf
	gui-lib/libfm-extra
	dev-util/gtk-doc"

src_prepare() {
	"${S}"/autogen.sh
	eautoreconf
	default
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
