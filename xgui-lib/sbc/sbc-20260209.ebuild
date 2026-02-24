# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="Audio codec to connect bluetooth HQ audio devices as headphones or loudspeakers"
HOMEPAGE="https://git.kernel.org/?p=bluetooth/sbc.git http://www.bluez.org/sbc-10/"
SNAPSHOT=b3deb8a5dcfb42d8c10ba1f2f1ac9bd7bf7271cc
SRC_URI="https://github.com/1g4-mirror/sbc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		$(use_enable static-libs static) \
		--disable-tester
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
