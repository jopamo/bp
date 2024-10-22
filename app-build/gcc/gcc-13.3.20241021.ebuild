# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="an optimizing compiler produced by the GNU Project supporting various programming languages"
HOMEPAGE="https://gcc.gnu.org/"

SNAPSHOT=8b43518a01cbbbafe042b85a48fa09a32948380a
SRC_URI="https://github.com/gcc-mirror/gcc/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/gcc-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug dlang go-bootstrap +isl sanitize +vtv zstd"

RESTRICT="strip"

DEPEND="
	lib-core/mpc
	lib-core/zlib
	app-build/binutils
	isl? ( lib-core/isl )
	zstd? ( app-compression/zstd )
"
BDEPEND="app-build/make"

PATCHES=(
	"${FILESDIR}"/0001-posix_memalign.patch
	"${FILESDIR}"/0006-Enable-Wformat-and-Wformat-security-by-default.patch
	"${FILESDIR}"/0007-Enable-Wtrampolines-by-default.patch
	"${FILESDIR}"/0009-Ensure-that-msgfmt-doesn-t-encounter-problems-during.patch
	"${FILESDIR}"/0010-Don-t-declare-asprintf-if-defined-as-a-macro.patch
	"${FILESDIR}"/0011-libiberty-copy-PIC-objects-during-build-process.patch
	"${FILESDIR}"/0012-libitm-disable-FORTIFY.patch
	"${FILESDIR}"/0014-nopie.patch
	"${FILESDIR}"/0019-build-fix-CXXFLAGS_FOR_BUILD-passing.patch
	"${FILESDIR}"/0020-add-fortify-headers-paths.patch
	"${FILESDIR}"/0024-use-pure-64-bit-configuration-where-appropriate.patch
	"${FILESDIR}"/0029-gcc-go-Don-t-include-sys-user.h.patch
)

src_prepare() {
	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-O3
	filter-flags -Wl,-z,combreloc
	filter-flags -Wl,-z,defs
	filter-flags -Wl,-z,now
	filter-flags -Wl,-z,relro
	filter-flags -fassociative-math
	filter-flags -fasynchronous-unwind-tables
	filter-flags -fcf-protection=full
	filter-flags -fexceptions
	filter-flags -fgraphite-identity
	filter-flags -fipa-pta
	filter-flags -floop-interchange
	filter-flags -floop-nest-optimize
	filter-flags -floop-parallelize-all
	filter-flags -flto*
	filter-flags -fno-math-errno
	filter-flags -fno-semantic-interposition
	filter-flags -fno-signed-zeros
	filter-flags -fno-trapping-math
	filter-flags -fpie
	filter-flags -fstack-clash-protection
	filter-flags -fstack-protector-strong
	filter-flags -ftree-loop-distribution
	filter-flags -fuse-linker-plugin

	replace-flags -O3 -O2

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

	emake -O STAGE1_CFLAGS="-O2" \
		BOOT_CFLAGS="$CFLAGS" \
		BOOT_LDFLAGS="$LDFLAGS" \
		LDFLAGS_FOR_TARGET="$LDFLAGS" \
		bootstrap

	make -O STAGE1_CFLAGS="-O2" \
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
