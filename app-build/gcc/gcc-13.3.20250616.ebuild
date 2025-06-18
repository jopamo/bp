# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="releases/gcc-$(ver_cut 1)"

inherit flag-o-matic

DESCRIPTION="an optimizing compiler produced by the GNU Project supporting various programming languages"
HOMEPAGE="https://gcc.gnu.org/"
SNAPSHOT=a2ce1bc5daa299bd4a77f6015e67fb3ebbdb4c32
SRC_URI="https://github.com/gcc-mirror/gcc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/gcc-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug dlang go-bootstrap +isl lib-only sanitize +vtv zstd"

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
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--includedir="${EPREFIX}"/usr/include
		--datadir="${EPREFIX}"/usr/share
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
		--disable-install-libiberty
		--disable-libgcj
		--disable-libgomp
		--disable-libmpx
		--disable-libmudflap
		--disable-libssp
		--disable-libstdcxx-pch
		--disable-libunwind-exceptions
		--disable-multilib
		--disable-nls
		--disable-obsolete
		--disable-rpath
		--disable-werror
		--enable-__cxa_atexit
		--enable-bootstrap
		--enable-cet=auto
		--enable-checking=release
		--enable-clocale=gnu
		--enable-default-pie
		--enable-default-ssp
		--enable-gnu-indirect-function
		--enable-gnu-unique-object
		--enable-languages=${GCC_LANG}
		--enable-libstdcxx-time
		--enable-linker-build-id
		--enable-lto
		--enable-plugin
		--enable-shared
		--enable-threads=posix
		--with-build-config="bootstrap-lto-lean"
		--with-linker-hash-style=gnu
		--with-system-zlib
		$(use_enable sanitize libsanitizer)
		$(use_enable vtv libvtv)
		$(use_enable vtv vtable-verify)
		$(use_with isl)
		$(use_with zstd)
	)
	../configure "${myconf[@]}"
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

	dobin "${FILESDIR}"/c89
	dobin "${FILESDIR}"/c99

	if use go-bootstrap; then
		exeinto /usr/lib/gccgo/bin/
		doexe "${ED}/usr/bin/go"
		doexe "${ED}/usr/bin/gofmt"

		cat > "${T}"/99gcc <<- EOF || die
			PATH=/usr/lib/gccgo/bin/
		EOF
		doenvd "${T}"/99gcc

		rm "${ED}/usr/bin/go"
		rm "${ED}/usr/bin/gofmt"
	fi

	dosym -r /usr/bin/gcc /usr/bin/cc
}
