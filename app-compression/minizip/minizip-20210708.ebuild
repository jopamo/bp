# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="zlib minizip"
HOMEPAGE="https://zlib.net/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/madler/zlib.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=c3f3043f7aa80750245f8166a338c4877020b589
	SRC_URI="https://github.com/madler/zlib/archive/${SNAPSHOT}.tar.gz -> zlib-${PV}.tar.gz"
	S=${WORKDIR}/zlib-${SNAPSHOT}/contrib/minizip
fi

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/lib/libminizip.{a,la} #419645
}
