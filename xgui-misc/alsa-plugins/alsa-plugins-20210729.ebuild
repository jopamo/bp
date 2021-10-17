# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="ALSA extra plugins"
HOMEPAGE="http://www.alsa-project.org/"

SNAPSHOT=da157e978d73f1947bb77637c324e19d003366d4
SRC_URI="https://github.com/alsa-project/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ffmpeg libsamplerate pulseaudio"

DEPEND="
	xmedia-live-lib/speexdsp
	>=xgui-misc/alsa-lib-${PV}
	ffmpeg? ( xmedia-live-app/ffmpeg:0= )
	libsamplerate? ( >=xmedia-live-lib/libsamplerate-0.1.8-r1 )
	pulseaudio? ( >=xgui-misc/pulseaudio-2.1-r1 )
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
		$(use_enable ffmpeg libav)
		$(use_enable libsamplerate samplerate)
		$(use_enable pulseaudio)
		--with-speex=lib
		--enable-speexdsp
		--disable-oss
		--disable-arcamav
		--disable-usbstream
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
