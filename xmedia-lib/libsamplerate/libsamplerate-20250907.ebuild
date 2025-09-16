# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Secret Rabbit Code (aka libsamplerate) is a Sample Rate Converter for audio"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SNAPSHOT=2ccde9568cca73c7b32c97fefca2e418c16ae5e3
SRC_URI="https://github.com/libsndfile/libsamplerate/archive/${SNAPSHOT}.tar.gz -> libsamplerate-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libsamplerate-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="sndfile static-libs keep-la"

DEPEND="sndfile? ( xgui-lib/libsndfile:= )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable sndfile)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
