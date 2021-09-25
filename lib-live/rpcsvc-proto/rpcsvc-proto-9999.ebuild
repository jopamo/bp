# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="rpcsvc protocol definitions from glibc"
HOMEPAGE="https://github.com/thkukuk/rpcsvc-proto"
EGIT_REPO_URI="https://github.com/thkukuk/rpcsvc-proto.git"

LICENSE="LGPL-2.1+ BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare(){
	default
	eautoreconf
}
