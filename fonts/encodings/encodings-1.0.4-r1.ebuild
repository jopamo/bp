# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="X.Org font encodings"

KEYWORDS="amd64 arm64 x86"
SRC_URI="https://www.x.org/archive/individual/font/${P}.tar.bz2"
SLOT=0

DEPEND="x11/mkfontscale
	>=fonts/font-util-1.1.1-r1"

ECONF_SOURCE="${S}"
