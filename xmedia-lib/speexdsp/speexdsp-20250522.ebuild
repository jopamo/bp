# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Audio compression format designed for speech -- DSP"
HOMEPAGE="https://www.speex.org/"

SNAPSHOT=e8a18dcd18cbbf2d86b1579605c2210e6fea4abb
SRC_URI="https://github.com/xiph/speexdsp/archive/${SNAPSHOT}.tar.gz -> speexdsp-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/speexdsp-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-lfs-flags

	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static)
}

src_install() {
	default

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
