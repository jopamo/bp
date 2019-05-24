# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="Common files for development of Gnome packages"
HOMEPAGE="https://git.gnome.org/browse/gnome-common"
EGIT_REPO_URI="https://github.com/GNOME/gnome-common.git"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64 arm64"
IUSE="+autoconf-archive"

src_prepare() {
	"${S}"/autogen.sh
	default
}

src_configure() {
	econf --with-autoconf-archive
}
