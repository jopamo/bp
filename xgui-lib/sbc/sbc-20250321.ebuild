# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Audio codec to connect bluetooth HQ audio devices as headphones or loudspeakers"
HOMEPAGE="https://git.kernel.org/?p=bluetooth/sbc.git http://www.bluez.org/sbc-10/"

SNAPSHOT=9b6c775f02b1ea944c8a203452ce23d7854e9187
SRC_URI="https://github.com/1g4-mirror/sbc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
        ECONF_SOURCE=${S} \
        econf \
                $(use_enable static-libs static) \
                --disable-tester
}
