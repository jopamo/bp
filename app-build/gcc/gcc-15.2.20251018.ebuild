# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="releases/gcc-$(ver_cut 1)"

inherit flag-o-matic

DESCRIPTION="an optimizing compiler produced by the GNU Project supporting various programming languages"
HOMEPAGE="https://gcc.gnu.org/"
SNAPSHOT=6caf0a581bf6eb3e587eda063c9485028854b730
SRC_URI="https://github.com/gcc-mirror/gcc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/gcc-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug dlang fortran go-bootstrap isl libgomp sanitize zstd"

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

	# libgo assumes off64_t exists everywhere, replace with off_t to unbreak musl / non-glibc
	sed -i 's/typedef off64_t libgo_off_t_type;/typedef off_t libgo_off_t_type;/g' libgo/sysinfo.c || die

	# make sure no CET codegen flags leak in from env or profiles
	# -fcf-protection and -mshstk/-mcet are x86-only and should not appear on arm64
	filter-flags \
		-fcf-protection=* \
		-mshstk \
		-mcet \
		-Wformat \
		-Wformat-security \
		-Werror=format-security \
		-ftrivial-auto-var-init=* \
		-fPIE \
		-fpie \
		-pipe

	filter-gcc
	filter-lto

	use debug || filter-flags -g

	default

	# do not run fixincludes (we don't want headers rewritten)
	sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in || die

	# do not use lib64
	sed -i '/^m64=/s/lib64/lib/' gcc/config/i386/t-linux64 || die

	# configure tests for header files using "$CPP $CPPFLAGS"
	# add -O2 so they don't get confused by stripped -pipe etc
	sed -i "/ac_cpp=/s/\$CPPFLAGS/\$CPPFLAGS -O2/" {libiberty,gcc}/configure || die

	mkdir -p gcc-build || die
}

src_configure() {
	local GCC_LANG="c,c++,lto"
	use dlang        && GCC_LANG+=",d"
	use go-bootstrap && GCC_LANG+=",go"
	use fortran      && GCC_LANG+=",fortran"

	cd gcc-build || die

	# using -pipe causes spurious test-suite failures
	CFLAGS=${CFLAGS/-pipe/}
	CXXFLAGS=${CXXFLAGS/-pipe/}

	# decide CET configure switch based on libc and arch
	local cet_opt="--disable-cet"
	if use elibc_glibc && [[ ${CHOST} == x86_64-* || ${CHOST} == i?86-* ]]; then
		cet_opt="--enable-cet"
	fi

	local myconf=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--with-slibdir="${EPREFIX}"/usr/lib
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

		${cet_opt}
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
	cd gcc-build || die

	emake -O \
		STAGE1_CFLAGS="${CFLAGS}" \
		BOOT_CFLAGS="${CFLAGS}" \
		BOOT_LDFLAGS="${LDFLAGS}" \
		LDFLAGS_FOR_TARGET="${LDFLAGS}" \
		bootstrap
}

src_install() {
	cd gcc-build || die

	emake DESTDIR="${ED}" install || die

	dobin "${FILESDIR}"/c89
	dobin "${FILESDIR}"/c99

	if use go-bootstrap; then
		exeinto /usr/lib/gccgo/bin
		doexe "${ED}/usr/bin/go"
		doexe "${ED}/usr/bin/gofmt"

		cat > "${T}"/99gcc <<-EOF || die
PATH=/usr/lib/gccgo/bin
EOF
		doenvd "${T}"/99gcc

		rm "${ED}/usr/bin/go"
		rm "${ED}/usr/bin/gofmt"
	fi

	dosym -r /usr/bin/gcc /usr/bin/cc

	find "${ED}"/usr/libexec/gcc -type f \
		\( -name 'libc?1*.la' -o -name 'libcp1plugin.la' \) -delete
}
