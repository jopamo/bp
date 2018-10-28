# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="https://fukuchi.org/works/qrencode/"
EGIT_REPO_URI="https://github.com/fukuchi/libqrencode.git"

LICENSE="LGPL-2"
SLOT="0/4"
KEYWORDS="amd64 arm64 x86"

RDEPEND="lib-media/libpng"

src_prepare(){
	eautoreconf
	default
}
