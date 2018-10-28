# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="https://github.com/libass/libass"
SRC_URI="https://github.com/libass/libass/releases/download/${PV}/${P}.tar.xz"

LICENSE="ISC"
SLOT="0/9" # subslot = libass soname version
KEYWORDS="amd64 arm64 x86"
IUSE="+fontconfig +harfbuzz static-libs"

RDEPEND="fontconfig? ( >=lib-media/fontconfig-2.10.92[${MULTILIB_USEDEP}] )
	>=lib-media/freetype-2.5.0.1:2[${MULTILIB_USEDEP}]
	>=lib-dev/fribidi-0.19.5-r1[${MULTILIB_USEDEP}]
	harfbuzz? ( >=lib-media/harfbuzz-0.9.12[truetype,${MULTILIB_USEDEP}] )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

X86_CPU_OPTS="abi_x86_32 abi_x86_64"
for i in ${X86_CPU_OPTS} ; do
	DEPEND="${DEPEND}
		${i}? ( dev-lang/nasm )"
done

DOCS="Changelog"

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable fontconfig) \
		$(use_enable harfbuzz) \
		$(use_enable static-libs static) \
		--disable-require-system-font-provider
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
