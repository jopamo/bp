# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Library to create and utilize caches to speed up freedesktop application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
KEYWORDS="amd64 arm64"

inherit git-r3 autotools
EGIT_REPO_URI="https://github.com/lxde/${PN}.git"

LICENSE="GPL-2"
SLOT="0/2"

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
