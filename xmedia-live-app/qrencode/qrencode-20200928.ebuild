# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="https://fukuchi.org/works/qrencode/"

SNAPSHOT=715e29fd4cd71b6e452ae0f4e36d917b43122ce8
SRC_URI="https://github.com/fukuchi/libqrencode/archive/${SNAPSHOT}.tar.gz -> libqrencode-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libqrencode-${SNAPSHOT}"

LICENSE="LGPL-2"
SLOT="0/4"
KEYWORDS="amd64 arm64"

RDEPEND="xmedia-live-lib/libpng"

src_prepare(){
	eautoreconf
	default
}
