# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Multi-platform library designed to allow a developer to create robust software"
HOMEPAGE="http://www.jedsoft.org/slang/"
SRC_URI="http://www.jedsoft.org/releases/${PN}/${P}.tar.bz2"
KEYWORDS="amd64 arm64 x86"

LICENSE="GPL-2"
SLOT="0"

MAKEOPTS+=" -j1"

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc
}
