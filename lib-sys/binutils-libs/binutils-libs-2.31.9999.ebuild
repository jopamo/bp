# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils toolchain-funcs multilib-minimal git-r3

DESCRIPTION="Core binutils libraries (libbfd, libopcodes, libiberty) for external packages"
HOMEPAGE="https://sourceware.org/binutils/"

EGIT_REPO_URI="git://sourceware.org/git/binutils-gdb.git"
EGIT_BRANCH="binutils-2_31-branch"

SLOT="0/2.31"
BVER=${SLOT}
SONAME=${SLOT}
S=${WORKDIR}/${P}

LICENSE="|| ( GPL-3 LGPL-3 )"

KEYWORDS="amd64 arm64 x86"

IUSE="64-bit-bfd multitarget nls static-libs"

COMMON_DEPEND="lib-sys/zlib[${MULTILIB_USEDEP}]"
DEPEND="${COMMON_DEPEND}
	>=sys-app/texinfo-4.7
	nls? ( sys-devel/gettext )"
# Need a newer binutils-config that'll reset include/lib symlinks for us.
RDEPEND="${COMMON_DEPEND}
	>=sys-devel/binutils-config-5
	nls? ( !<sys-devel/gdb-7.10-r1[nls] )"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/bfd.h
)

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--disable-obsolete
		--enable-shared
		--enable-threads
		--enable-install-libiberty
		--disable-werror
		--without-zlib
		--with-system-zlib
		--disable-{binutils,etc,ld,gas,gold,gprof}
		--disable-{gdb,libdecnumber,readline,sim}
		--without-stage1-ldflags
		$(use_enable static-libs static)
		$(use_enable 64-bit-bfd)
	)

	use multitarget && myconf+=( --enable-targets=all --enable-64-bit-bfd )

	use nls \
		&& myconf+=( --without-included-gettext ) \
		|| myconf+=( --disable-nls )

	ECONF_SOURCE=${S} \
	econf "${myconf[@]}"
}

multilib_src_install() {
	default
	# Provide libiberty.h directly.
	dosym libiberty/libiberty.h /usr/include/libiberty.h
}

multilib_src_install_all() {
	use static-libs || find "${ED}"/usr -name '*.la' -delete
}
