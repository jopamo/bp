# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ASN.1 library"
HOMEPAGE="https://www.gnu.org/software/libtasn1/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs valgrind"

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_enable valgrind valgrind-tests)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
