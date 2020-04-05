# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Minimalistic netlink library"
HOMEPAGE="http://netfilter.org/projects/libmnl"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="examples static-libs"

PATCHES=(
			${FILESDIR}/37c876b55a2c00424ccda5a300ab5fdec1d88b22.patch
			${FILESDIR}/fbe0f33b45abd585eb9f52cb56d751a750667dc6.patch
)

src_configure() {
	econf $(use_enable static-libs static)
}
