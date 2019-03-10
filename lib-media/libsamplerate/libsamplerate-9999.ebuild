# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Secret Rabbit Code (aka libsamplerate) is a Sample Rate Converter for audio"
HOMEPAGE="http://www.mega-nerd.com/SRC/"

if [[ ${PV} == *9999 ]]; then
	inherit autotools git-r3
	EGIT_REPO_URI="https://github.com/erikd/libsamplerate.git"
else
	SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"
fi
KEYWORDS="amd64 arm64"

LICENSE="BSD-2"
SLOT="0"
IUSE="sndfile static-libs test"
REQUIRED_USE="test? ( sndfile )"

RDEPEND="
	sndfile? (
		lib-media/libsndfile:=
	)"
# Alsa/FFTW are only consumed
# by tests, not by the main library.
DEPEND="
	${RDEPEND}
	test? (
		lib-media/alsa-lib
		sci-libs/fftw:3.0
	)
	dev-util/pkgconfig"

src_prepare() {
	default

	[[ ${PV} == *9999 ]] && eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable sndfile) \
		$(use_enable static-libs static) \
		$(use_enable test alsa) \
		$(use_enable test fftw)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
