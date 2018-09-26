# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic multilib toolchain-funcs eutils multilib-minimal git-r3

DESCRIPTION="A free library for encoding X264/AVC streams"
HOMEPAGE="https://www.videolan.org/developers/x264.html"

EGIT_REPO_URI="https://git.videolan.org/git/x264.git"
KEYWORDS="amd64 arm64 x86"

SONAME="152"
SLOT="0/${SONAME}"

LICENSE="GPL-2"
IUSE="+interlaced opencl static-libs pic"

ASM_DEP=">=dev-lang/nasm-2.13"
DEPEND="abi_x86_32? ( ${ASM_DEP} )
	abi_x86_64? ( ${ASM_DEP} )
	opencl? ( dev-lang/perl )
	app-media/ffmpeg[${MULTILIB_USEDEP}]
	lib-media/l-smash[${MULTILIB_USEDEP}]
	lib-media/ffmpegsource[${MULTILIB_USEDEP}]"

RDEPEND="opencl? ( >=virtual/opencl-0-r3[${MULTILIB_USEDEP}] )
	abi_x86_32? ( !<=app-misc/emul-linux-x86-medialibs-20130224-r7
		!app-misc/emul-linux-x86-medialibs[-abi_x86_32(-)] )
		${DEPEND}"

RESTRICT="test"

multilib_src_configure() {
	append-flags -ffat-lto-objects
	tc-export CC

	"${S}/configure" \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--disable-avs \
		--disable-gpac \
		$(usex pic "--enable-pic" "") \
		--enable-shared \
		--host="${CHOST}" \
		$(usex interlaced "" "--disable-interlaced") \
		$(usex opencl "" "--disable-opencl") \
		$(usex static-libs "--enable-static" "") || die
}
