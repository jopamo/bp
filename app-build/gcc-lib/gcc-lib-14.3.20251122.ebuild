# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="releases/gcc-$(ver_cut 1)"

inherit flag-o-matic

DESCRIPTION="an optimizing compiler produced by the GNU Project supporting various programming languages"
HOMEPAGE="https://gcc.gnu.org/"
SNAPSHOT=52e1841b57e317f5cafd4ba09b2d98ce32d3a5be
SRC_URI="https://github.com/gcc-mirror/gcc/archive/${SNAPSHOT}.tar.gz -> gcc-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/gcc-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug dlang go-bootstrap isl libgomp sanitize zstd"

RESTRICT="strip"

DEPEND="
	lib-core/mpc
	lib-core/zlib
	app-build/binutils
	isl? ( lib-core/isl )
	zstd? ( app-compression/zstd )
"
BDEPEND="app-build/make"

src_prepare() {
	eapply "${FILESDIR}"/$(ver_cut 1)/*.patch
	sed -i 's/typedef off64_t libgo_off_t_type;/typedef off_t libgo_off_t_type;/g' libgo/sysinfo.c || die

	filter-gcc
    filter-lto

	use debug || filter-flags -g

	default

	# Do not run fixincludes
	sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in

	# install x86_64 libraries in /lib
	sed -i '/m64=/s/lib64/lib/' gcc/config/i386/t-linux64

	# configure tests for header files using "$CPP $CPPFLAGS"
	sed -i "/ac_cpp=/s/\$CPPFLAGS/\$CPPFLAGS -O2/" {libiberty,gcc}/configure

	mkdir -p gcc-build
}

src_configure() {
	local GCC_LANG="c,c++,lto"

	use dlang   && GCC_LANG+=",d"
	use go-bootstrap  && GCC_LANG+=",go"

	cd gcc-build

	# using -pipe causes spurious test-suite failures
	# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48565
	CFLAGS=${CFLAGS/-pipe/}
	CXXFLAGS=${CXXFLAGS/-pipe/}

	local myconf=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--includedir="${EPREFIX}"/usr/include
		--datadir="${EPREFIX}"/usr/share
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
		--disable-fixed-point
		--disable-install-libiberty
		--disable-libgcj
		--disable-libmpx
		--disable-libmudflap
		--disable-libssp
		--disable-libstdcxx-pch
		--disable-multilib
		--disable-nls
		--disable-obsolete
		--disable-rpath
		--disable-werror
		--enable-__cxa_atexit
		--enable-bootstrap
		--enable-checking=release
		--enable-clocale=generic
		--enable-default-pie
		--enable-languages=${GCC_LANG}
		--enable-libstdcxx-time
		--enable-link-mutex
		--enable-linker-build-id
		--enable-lto
		--enable-plugin
		--enable-shared
		--enable-threads=posix
		--with-build-config="bootstrap-lto-lean"
		--with-linker-hash-style=gnu
		--with-pkgversion="1g4 Linux GCC ${PV}"
		--with-system-zlib
		$(use_enable elibc_glibc cet)
		$(use_enable elibc_glibc symvers)
		$(use_enable elibc_glibc libvtv)
		$(use_enable elibc_glibc vtable-verify)
		$(use_enable elibc_glibc default-ssp)
		$(use_enable elibc_glibc gnu-indirect-function)
		$(use_enable elibc_glibc gnu-unique-object)
		$(use_enable libgomp)
		$(use_enable sanitize libsanitizer)
		$(use_with isl)
		$(use_with zstd)
	)
	../configure "${myconf[@]}" || die
}

src_compile() {
	cd gcc-build

	emake -O STAGE1_CFLAGS="$CFLAGS" \
		BOOT_CFLAGS="$CFLAGS" \
		BOOT_LDFLAGS="$LDFLAGS" \
		LDFLAGS_FOR_TARGET="$LDFLAGS" \
		bootstrap

	make -O STAGE1_CFLAGS="$CFLAGS" \
		BOOT_CFLAGS="$CFLAGS" \
		BOOT_LDFLAGS="$LDFLAGS" \
		LDFLAGS_FOR_TARGET="$LDFLAGS" \
		all-gcc

}

src_install() {
	cd gcc-build
	emake DESTDIR="${ED}" install

	#cleanup
	find "${ED}" -name libcc1.la -delete
	find "${ED}" -name libcc1plugin.la -delete
	find "${ED}" -name libcp1plugin.la -delete

	rm -rf "${ED}"/usr/bin
	rm -rf "${ED}"/usr/include
	rm -rf "${ED}"/usr/share
	rm -rf "${ED}"/usr/lib/gcc
	rm -rf "${ED}"/usr/libexec
}
