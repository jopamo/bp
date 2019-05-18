# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="Audio compression format designed for speech -- DSP"
HOMEPAGE="https://www.speex.org/"
EGIT_REPO_URI="https://github.com/xiph/speexdsp.git"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-lfs-flags

	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static)
}
