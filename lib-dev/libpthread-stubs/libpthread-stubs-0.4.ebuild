# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pthread functions stubs for platforms missing them"
SRC_URI="https://xcb.freedesktop.org/dist/${P}.tar.bz2"
SLOT=0
KEYWORDS="amd64 arm64"

src_configure() {
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
