# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="IPset tool for iptables, successor to ippool"
HOMEPAGE="http://ipset.netfilter.org/"
SRC_URI="http://ipset.netfilter.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-net/iptables
	lib-net/libmnl
"

PATCHES=( "${FILESDIR}"/ipset_disable_cflags.patch )

src_configure() {
	econf --without-kmod
}
