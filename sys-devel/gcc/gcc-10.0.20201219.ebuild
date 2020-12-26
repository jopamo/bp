# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT="$(ver_cut 1)-$(ver_cut 3-)"

inherit flag-o-matic

DESCRIPTION="gcc"
HOMEPAGE="https://gcc.gnu.org/"
SRC_URI="http://www.netgull.com/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT}.tar.xz
		https://bigsearcher.com/mirrors/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT}.tar.xz
		http://mirrors.concertpass.com/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT}.tar.xz"
S=${WORKDIR}/gcc-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug openmp +isl sanitize +vtv"

filter-flags -D_FORTIFY_SOURCE\=\* -Wl,-z,combreloc -Wl,-z,relro -Wl,-z,defs -Wl,-z,now -fstack-protector-strong -fstack-clash-protection

src_prepare() {
	strip-flags
	use debug || filter-flags -g

	default

	# Do not run fixincludes
	sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in

	# Arch Linux installs x86_64 libraries /lib
	sed -i '/m64=/s/lib64/lib/' gcc/config/i386/t-linux64

	# configure tests for header files using "$CPP $CPPFLAGS"
	sed -i "/ac_cpp=/s/\$CPPFLAGS/\$CPPFLAGS -O2/" {libiberty,gcc}/configure

	mkdir -p gcc-build
}

src_configure() {
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
		--enable-languages=c,c++,lto
    	--with-linker-hash-style=gnu
    	--with-system-zlib
    	--enable-__cxa_atexit
    	--enable-cet=auto
    	--enable-checking=release
    	--enable-clocale=gnu
    	--enable-default-pie
    	--enable-default-ssp
    	--enable-gnu-indirect-function
    	--enable-gnu-unique-object
    	--enable-install-libiberty
    	--enable-linker-build-id
    	--enable-lto
    	--disable-multilib
    	--enable-plugin
    	--enable-shared
    	--enable-threads=posix
      	--disable-libssp
      	--disable-libstdcxx-pch
      	--disable-libunwind-exceptions
      	--disable-werror
      	--disable-obsolete
      	--disable-libmudflap
      	--enable-nls
      	--enable-libstdcxx-time
      	--disable-rpath
      	--enable-__cxa_atexit
      	--disable-libmpx
		--disable-libgcj
		--enable-bootstrap
		--with-build-config="bootstrap-lto-lean"
		$(use_with isl)
		$(use_enable openmp libgomp)
		$(use_enable vtv vtable-verify)
		$(use_enable vtv libvtv)
		$(use_enable sanitize libsanitizer)
	)
	../configure "${myconf[@]}"
}

src_compile() {
	cd gcc-build
	emake
}

src_install() {
	cd gcc-build
	emake DESTDIR="${ED}" install
}
