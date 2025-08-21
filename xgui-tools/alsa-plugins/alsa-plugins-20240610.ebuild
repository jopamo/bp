# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="ALSA extra plugins"
HOMEPAGE="http://www.alsa-project.org/"
SNAPSHOT=52574cb5ccbb8b546df2759e4b341a20332269b6
SRC_URI="https://github.com/alsa-project/alsa-plugins/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ffmpeg libsamplerate pulseaudio"

DEPEND="
	>=xgui-tools/alsa-lib-${PV}
	xmedia-lib/speexdsp
	ffmpeg? ( xmedia-app/ffmpeg )
	libsamplerate? ( xmedia-lib/libsamplerate )
	pulseaudio? ( xgui-misc/pulseaudio )
"

src_prepare() {
	default

	sed -i \
		-e '/AM_CFLAGS/s:-Wall:-DNDEBUG -Wall:' \
		pulse/Makefile.am || die

	eautoreconf
}

src_configure() {
	use debug || append-cppflags -DNDEBUG

	local myconf=(
		--disable-libav
		$(use_enable libsamplerate samplerate)
		$(use_enable pulseaudio)
		--disable-arcamav
		--disable-oss
		--disable-usbstream
		--enable-speexdsp
		--with-speex=lib
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
