# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="IPset tool for iptables, successor to ippool"
HOMEPAGE="http://ipset.netfilter.org/"
SNAPSHOT=4197c747268ed1129e73f5da25f6f17f97103141
SRC_URI="https://github.com/1g4-mirror/ipset/archive/${SNAPSHOT}.tar.gz -> ipset-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/ipset-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-net/iptables
	lib-net/libmnl
"

PATCHES=( "${FILESDIR}"/ipset_disable_cflags.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --without-kmod
}
