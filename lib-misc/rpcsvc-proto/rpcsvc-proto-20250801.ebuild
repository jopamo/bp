# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="rpcsvc protocol definitions from glibc"
HOMEPAGE="https://github.com/thkukuk/rpcsvc-proto"
SNAPSHOT=cd6ecf8f0ef1abaf8c29f1d3339af6207c060e5f
SRC_URI="https://github.com/thkukuk/rpcsvc-proto/archive/${SNAPSHOT}.tar.gz -> rpcsvc-proto-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rpcsvc-proto-${SNAPSHOT}"

LICENSE="LGPL-2.1+ BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare(){
	default
	eautoreconf
}
