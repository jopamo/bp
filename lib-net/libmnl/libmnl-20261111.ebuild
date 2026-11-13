# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Minimalistic netlink library"
HOMEPAGE="http://netfilter.org/projects/libmnl"
SNAPSHOT=c2f0565f4bd6f49033b0de9aab5bfbc3b9a75fe2
SRC_URI="https://github.com/1g4-mirror/libmnl/archive/${SNAPSHOT}.tar.gz -> libmnl-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libmnl-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"
BDEPEND="app-dev/patchelf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure

	econf $(use_enable static-libs static)
}

src_install() {
	default

	qa-policy-install
}
