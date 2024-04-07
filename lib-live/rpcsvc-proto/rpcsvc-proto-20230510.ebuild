# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="rpcsvc protocol definitions from glibc"
HOMEPAGE="https://github.com/thkukuk/rpcsvc-proto"

SNAPSHOT=c65926005e50da02a4da3e26abc42eded36cd19d
SRC_URI="https://github.com/thkukuk/rpcsvc-proto/archive/${SNAPSHOT}.tar.gz -> rpcsvc-proto-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rpcsvc-proto-${SNAPSHOT}"

LICENSE="LGPL-2.1+ BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare(){
	default
	eautoreconf
}
