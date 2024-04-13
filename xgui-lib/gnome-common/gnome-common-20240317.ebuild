# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Common files for development of Gnome packages"
HOMEPAGE="https://git.gnome.org/browse/gnome-common"

SNAPSHOT=eb124d02f3da574f40360ae64d4fc21af9a2c148
SRC_URI="https://gitlab.gnome.org/GNOME/gnome-common/-/archive/${SNAPSHOT}/gnome-common-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
