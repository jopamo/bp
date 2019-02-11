# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="X.Org font aliases"
SRC_URI="https://www.x.org/archive/individual/font/${P}.tar.bz2"
SLOT=0
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}
	x11/mkfontscale
	>=fonts/font-util-1.1.1-r1"

PATCHES=( "${FILESDIR}"/${P}-cvs-tags.patch ) #521786
