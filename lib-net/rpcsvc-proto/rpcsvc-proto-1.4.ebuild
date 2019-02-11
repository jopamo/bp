# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="rpcsvc protocol definitions from glibc"
HOMEPAGE="https://github.com/thkukuk/rpcsvc-proto"
SRC_URI="https://github.com/thkukuk/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1+ BSD"
KEYWORDS="amd64 arm64"

src_prepare(){
	default
	eautoreconf
}

src_install(){
	default

	# provided by sys-fs/quota[rpc]
	rm "${ED%/}"/usr/include/rpcsvc/rquota.{x,h} || die
}
