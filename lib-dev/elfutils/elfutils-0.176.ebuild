# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SRC_URI="https://sourceware.org/elfutils/ftp/${PV}/${P}.tar.bz2"

LICENSE="|| ( GPL-2+ LGPL-3+ ) utils? ( GPL-3+ )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="bzip2 lzma nls static-libs test +utils"

RDEPEND=">=lib-sys/zlib-1.2.8-r1
	bzip2? ( >=app-compression/lbzip2-1.0.6-r4 )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1 )
	!lib-dev/libelf"
DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.4a
	sys-devel/m4"

filter-flags -flto

src_prepare() {
	default

	if ! use static-libs; then
		sed -i -e '/^lib_LIBRARIES/s:=.*:=:' -e '/^%.os/s:%.o$::' lib{asm,dw,elf}/Makefile.in || die
	fi
	sed -i 's:-Werror::' */Makefile.in || die
}

src_configure() {
	use test && append-flags -g #407135
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable nls)
		--program-prefix="eu-"
		--with-zlib
		$(use_with bzip2 bzlib)
		$(use_with lzma)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	env	LD_LIBRARY_PATH="${BUILD_DIR}/libelf:${BUILD_DIR}/libebl:${BUILD_DIR}/libdw:${BUILD_DIR}/libasm" \
		LC_ALL="C" \
		emake check
}

src_install() {
	default
	if ! use utils; then
		rm -rf "${ED}"/usr/bin || die
	fi
}
