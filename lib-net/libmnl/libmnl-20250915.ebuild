# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Minimalistic netlink library"
HOMEPAGE="http://netfilter.org/projects/libmnl"
SNAPSHOT=54dea548d796653534645c6e3c8577eaf7d77411
SRC_URI="https://github.com/1g4-mirror/libmnl/archive/${SNAPSHOT}.tar.gz -> libmnl-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libmnl-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
