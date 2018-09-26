# Distributed under the terms of the GNU General Public License v2

EAPI="5"

EGIT_REPO_URI=https://git.enlightenment.org/legacy/imlib2.git

inherit toolchain-funcs multilib-minimal git-r3 autotools

DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="https://www.enlightenment.org/"
KEYWORDS="amd64 arm64 x86"

IUSE="bzip2 gif jpeg cpu_flags_x86_mmx cpu_flags_x86_sse2 mp3 png static-libs tiff X zlib"
SLOT=0
RDEPEND="lib-media/freetype:2[${MULTILIB_USEDEP}]
	bzip2? ( >=app-compression/lbzip2-1.0.6-r4[${MULTILIB_USEDEP}] )
	zlib? ( >=lib-sys/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )
	gif? ( >=lib-media/giflib-4.1.6-r3:0=[${MULTILIB_USEDEP}] )
	png? ( >=lib-media/libpng-1.6.10:0=[${MULTILIB_USEDEP}] )
	jpeg? ( lib-media/libjpeg-turbo[${MULTILIB_USEDEP}] )
	tiff? ( >=lib-media/tiff-4.0.3-r6:0[${MULTILIB_USEDEP}] )
	X? (
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
	)
	mp3? ( >=lib-media/libid3tag-0.15.1b-r3[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]
	X? ( x11/xorgproto )"

src_prepare() {
	eautoreconf
}

multilib_src_configure() {
	# imlib2 has diff configure options for x86/amd64 assembly
	if [[ $(tc-arch) == amd64 ]]; then
		E_ECONF+=( $(use_enable cpu_flags_x86_sse2 amd64) --disable-mmx )
	else
		E_ECONF+=( --disable-amd64 $(use_enable cpu_flags_x86_mmx mmx) )
	fi

	[[ $(gcc-major-version) -ge 4 ]] && E_ECONF+=( --enable-visibility-hiding )

	ECONF_SOURCE="${S}" \
	E_ECONF+=(
		$(use_enable static-libs static)
		$(use_with X x)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
		$(use_with gif)
		$(use_with zlib)
		$(use_with bzip2)
		$(use_with mp3 id3)
	)

	has static-libs ${IUSE} && E_ECONF+=( $(use_enable static-libs static) )

	econf ${MY_ECONF} "${E_ECONF[@]}"
}
