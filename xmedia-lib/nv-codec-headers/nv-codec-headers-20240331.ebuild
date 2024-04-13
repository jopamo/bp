# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FFmpeg version of headers required to interface with Nvidias codec APIs"
HOMEPAGE="https://git.videolan.org/?p=ffmpeg/nv-codec-headers.git"

SNAPSHOT=9934f17316b66ce6de12f3b82203a298bc9351d8
SRC_URI="https://github.com/FFmpeg/nv-codec-headers/archive/${SNAPSHOT}.tar.gz -> nv-codec-headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/nv-codec-headers-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="bin/nvidia-drivers"

src_compile() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="lib"
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="lib" DESTDIR="${D}" install
}
