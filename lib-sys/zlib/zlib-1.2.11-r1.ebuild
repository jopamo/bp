# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools toolchain-funcs eutils

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="https://zlib.net/"
SRC_URI="https://zlib.net/${P}.tar.gz
	http://www.gzip.org/zlib/${P}.tar.gz
	http://www.zlib.net/current/beta/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0/1" # subslot = SONAME
KEYWORDS="amd64 arm64"
IUSE="+minizip static-libs"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.11-fix-deflateParams-usage.patch

	if use minizip ; then
		cd contrib/minizip || die
		eautoreconf
	fi
}

echoit() { echo "$@"; "$@"; }

src_configure() {
	case ${CHOST} in
	*-mingw*|mingw*)
		;;
	*)      # not an autoconf script, so can't use econf
		local uname=$("${EPREFIX}"/usr/share/gnuconfig/config.sub "${CHOST}" | cut -d- -f3) #347167
		echoit "${S}"/configure \
			--shared \
			--prefix="${EPREFIX}/usr" \
			--libdir="${EPREFIX}/usr/lib64" \
			${uname:+--uname=${uname}} \
			|| die
		;;
	esac

	if use minizip ; then
		local minizipdir="contrib/minizip"
		mkdir -p "${minizipdir}" || die
		cd ${minizipdir} || die
		ECONF_SOURCE="${S}/${minizipdir}" \
		econf $(use_enable static-libs static)
	fi
}

src_compile() {
	case ${CHOST} in
	*-mingw*|mingw*)
		emake -f win32/Makefile.gcc STRIP=true PREFIX=${CHOST}-
		sed \
			-e 's|@prefix@|/usr|g' \
			-e 's|@exec_prefix@|${prefix}|g' \
			-e 's|@libdir@|${exec_prefix}/'lib64'|g' \
			-e 's|@sharedlibdir@|${exec_prefix}/'lib64'|g' \
			-e 's|@includedir@|${prefix}/include|g' \
			-e 's|@VERSION@|'${PV}'|g' \
			zlib.pc.in > zlib.pc || die
		;;
	*)
		emake
		;;
	esac
	use minizip && emake -C contrib/minizip
}

sed_macros() {
	# clean up namespace a little #383179
	# we do it here so we only have to tweak 2 files
	sed -i -r 's:\<(O[FN])\>:_Z_\1:g' "$@" || die
}

src_install() {
	case ${CHOST} in
	*-mingw*|mingw*)
		emake -f win32/Makefile.gcc install \
			BINARY_PATH="${ED}/usr/bin" \
			LIBRARY_PATH="${ED}/usr/lib64" \
			INCLUDE_PATH="${ED}/usr/include" \
			SHARED_MODE=1
		# overwrites zlib.pc created from win32/Makefile.gcc #620136
		insinto /usr/lib64/pkgconfig
		doins zlib.pc
		;;

	*)
		emake install DESTDIR="${ED}" LDCONFIG=:
		;;
	esac
	sed_macros "${ED}"/usr/include/*.h

	if use minizip ; then
		emake -C contrib/minizip install DESTDIR="${ED}"
		sed_macros "${ED}"/usr/include/minizip/*.h
	fi

	use static-libs || rm -f "${ED}"/usr/lib64/lib{z,minizip}.{a,la} #419645
}
