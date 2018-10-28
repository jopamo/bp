# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="Minimalistic netlink library"
HOMEPAGE="http://netfilter.org/projects/libmnl"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0/0.2.0"
KEYWORDS="amd64 arm64 x86"
IUSE="examples static-libs"

src_configure() {
	econf $(use_enable static-libs static)
}
