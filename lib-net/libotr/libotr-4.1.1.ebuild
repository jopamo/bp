# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="https://otr.cypherpunks.ca"
SRC_URI="https://otr.cypherpunks.ca/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
		lib-core/libgpg-error
		lib-core/libgcrypt
"

src_install() {
	default
	use static-libs || rm "${ED}"/usr/lib/libotr.a
}
