# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://lame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="debug cpu_flags_x86_mmx +frontend mp3rtp sndfile static-libs"

# These deps are without MULTILIB_USEDEP and are correct since we only build
# libmp3lame for multilib and these deps apply to the lame frontend executable.
RDEPEND="
	frontend? (
		>=lib-sys/ncurses-5.7-r7:0=
		sndfile? ( >=lib-media/libsndfile-1.0.2 )
	)
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	cpu_flags_x86_mmx? ( dev-lang/nasm )"

src_prepare() {
	default

	mkdir libmp3lame/i386/.libs || die #workaround parallel build with nasm

	sed -i -e '/define sp/s/+/ + /g' libmp3lame/i386/nasm.h || die

	use cpu_flags_x86_mmx || sed -i -e '/AC_PATH_PROG/s:nasm:dIsAbLe&:' configure.in #361879

	AT_M4DIR=. eautoreconf
}

multilib_src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug debug norm)
		--disable-mp3x
		--enable-dynamic-frontends
	)
	use cpu_flags_x86_mmx && myconf+=( --enable-nasm ) #361879

	# Only build the frontend for the default ABI.
	if [ "${ABI}" = "${DEFAULT_ABI}" ] ; then
		myconf+=( $(use_enable mp3rtp) $(use_enable frontend) )
		use sndfile && myconf+=( --with-fileio=sndfile )
	else
		myconf+=( --disable-frontend --disable-mp3rtp )
	fi

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

multilib_src_install() {
	emake DESTDIR="${D}" pkghtmldir="${EPREFIX}/usr/share/doc/${PF}/html" install
}

multilib_src_install_all() {
	cd "${S}"
	dobin misc/mlame

	dodoc API ChangeLog HACKING README STYLEGUIDE TODO USAGE
	docinto html
	dodoc misc/lameGUI.html Dll/LameDLLInterface.htm

	find "${ED}" -name '*.la' -exec rm -f {} +
}
