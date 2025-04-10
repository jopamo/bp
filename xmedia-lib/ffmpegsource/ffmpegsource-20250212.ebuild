# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="An FFmpeg based source library and Avisynth/VapourSynth plugin for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"

SNAPSHOT=941746519d6a5dde2c55698aa5883ae65f9cf718
SRC_URI="https://github.com/FFMS/ffms2/archive/${SNAPSHOT}.tar.gz -> ffms2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ffms2-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/zlib
	xmedia-app/ffmpeg
"
BDEPEND="app-dev/pkgconf"

src_prepare() {
	mkdir -p "${S}/src/config"
	default
	eautoreconf
}
