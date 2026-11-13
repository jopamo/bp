# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="C++ unit testing framework"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/cppunit/"
SRC_URI="https://dev-www.libreoffice.org/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	qa-policy-configure
	econf --disable-static --disable-doxygen --disable-werror
}

src_install() {
	default
	qa-policy-install
}
