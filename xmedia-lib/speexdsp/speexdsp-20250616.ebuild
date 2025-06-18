# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Audio compression format designed for speech -- DSP"
HOMEPAGE="https://www.speex.org/"
SNAPSHOT=a51b1e8b42f1e40f634831353d3ed4c590d5ec2a
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
