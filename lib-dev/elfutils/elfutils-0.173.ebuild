# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic multilib-minimal

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SRC_URI="https://sourceware.org/elfutils/ftp/${PV}/${P}.tar.bz2"

LICENSE="|| ( GPL-2+ LGPL-3+ ) utils? ( GPL-3+ )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="bzip2 lzma nls static-libs test +threads +utils"

RDEPEND=">=lib-sys/zlib-1.2.8-r1[${MULTILIB_USEDEP}]
	bzip2? ( >=app-compression/lbzip2-1.0.6-r4[${MULTILIB_USEDEP}] )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1[${MULTILIB_USEDEP}] )
	!lib-dev/libelf"
DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.4a
	sys-devel/m4"

PATCHES=("${FILESDIR}"/${PN}-0.118-PaX-support.patch)

src_prepare() {
	default

	if ! use static-libs; then
		sed -i -e '/^lib_LIBRARIES/s:=.*:=:' -e '/^%.os/s:%.o$::' lib{asm,dw,elf}/Makefile.in || die
	fi
	sed -i 's:-Werror::' */Makefile.in || die
}

src_configure() {
	use test && append-flags -g #407135
	multilib-minimal_src_configure
}

multilib_src_configure() {
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		$(use_enable nls)
		--program-prefix="eu-"
		--with-zlib
		$(use_with bzip2 bzlib)
		$(use_with lzma)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_test() {
	env	LD_LIBRARY_PATH="${BUILD_DIR}/libelf:${BUILD_DIR}/libebl:${BUILD_DIR}/libdw:${BUILD_DIR}/libasm" \
		LC_ALL="C" \
		emake check
}

multilib_src_install_all() {
	if ! use utils; then
		rm -rf "${ED}"/usr/bin || die
	fi
}
