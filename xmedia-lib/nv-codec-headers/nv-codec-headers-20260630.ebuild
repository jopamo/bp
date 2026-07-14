# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="FFmpeg version of headers required to interface with Nvidias codec APIs"
HOMEPAGE="https://git.videolan.org/?p=ffmpeg/nv-codec-headers.git"
SNAPSHOT=15ee32753c92faddbabbff11676779618fc6db7e
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
