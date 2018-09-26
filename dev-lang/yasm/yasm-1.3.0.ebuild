# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="An assembler for x86 and x86_64 instruction sets"
HOMEPAGE="http://yasm.tortall.net/"
SRC_URI="http://www.tortall.net/projects/yasm/releases/${P}.tar.gz"

LICENSE="BSD-2 BSD || ( Artistic GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="nls"

RDEPEND="
	nls? ( sys-devel/gettext )
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"

src_configure() {

	XMLTO=: \
	econf \
		$(use_enable nls)
}

src_test() {
	emake check
}
