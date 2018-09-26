# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3

DESCRIPTION="FFmpeg version of headers required to interface with Nvidias codec APIs"
HOMEPAGE="https://git.videolan.org/?p=ffmpeg/nv-codec-headers.git"
EGIT_REPO_URI="https://github.com/FFmpeg/nv-codec-headers.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="nvidia/nvidia-drivers[${MULTILIB_USEDEP}]"

src_prepare() {
	multilib_copy_sources
	default
}

multilib_src_compile() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="$(get_libdir)"
}

multilib_src_install() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="$(get_libdir)" DESTDIR="${D}" install
}
