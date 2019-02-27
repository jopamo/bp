# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="FFmpeg version of headers required to interface with Nvidias codec APIs"
HOMEPAGE="https://git.videolan.org/?p=ffmpeg/nv-codec-headers.git"
EGIT_REPO_URI="https://github.com/FFmpeg/nv-codec-headers.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="nvidia/nvidia-drivers"

src_compile() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="lib64"
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="lib64" DESTDIR="${D}" install
}
