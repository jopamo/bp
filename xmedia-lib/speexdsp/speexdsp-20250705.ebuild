# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Audio compression format designed for speech -- DSP"
HOMEPAGE="https://www.speex.org/"
SNAPSHOT=7a158783df74efe7c2d1c6ee8363c1e695c71226
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
