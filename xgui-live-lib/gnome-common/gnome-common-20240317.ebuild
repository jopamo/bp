# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Common files for development of Gnome packages"
HOMEPAGE="https://git.gnome.org/browse/gnome-common"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gnome-common"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf --with-autoconf-archive
}
