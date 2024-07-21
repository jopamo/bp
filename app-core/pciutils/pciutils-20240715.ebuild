# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A library and various utilities dealing with the PCI bus"
HOMEPAGE="http://mj.ucw.cz/sw/pciutils/ https://git.kernel.org/?p=utils/pciutils/pciutils.git"

SNAPSHOT=1bfc2be0ce96f05536764d6ac230d596aefd8dfa
SRC_URI="https://github.com/pciutils/pciutils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dns kmod static-libs +udev zlib"

DEPEND="
	app-core/pciids
	kmod? ( app-core/kmod
			app-dev/pkgconf
		 )
	zlib? ( lib-core/zlib[static-libs(+)?] )
"

switch_config() {
	[[ $# -ne 2 ]] && return 1
	local opt=$1 val=$2

	sed "s@^\(${opt}=\).*\$@\1${val}@" -i Makefile || die
	return 0
}

src_prepare() {
	default

	if use static-libs ; then
		cp -pPR "${S}" "${S}.static" || die
		mv "${S}.static" "${S}/static" || die
	fi
}

src_configure() {
	append-lfs-flags
}

pemake() {
	emake \
		HOST="${CHOST}" \
		CROSS_COMPILE="${CHOST}-" \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		RANLIB="$(tc-getRANLIB)" \
		DNS=$(usex dns) \
		IDSDIR='$(SHAREDIR)/misc' \
		MANDIR='$(SHAREDIR)/man' \
		PREFIX="${EPREFIX}/usr" \
		SHARED="yes" \
		STRIP="" \
		ZLIB=$(usex zlib) \
		PCI_COMPRESSED_IDS=0 \
		PCI_IDS="/usr/share/hwdata/pci.ids" \
		LIBDIR="\${PREFIX}/lib" \
		LIBKMOD=$(usex kmod) \
		HWDB=$(usex udev) \
		"$@"
}

src_compile() {
	pemake OPT="${CFLAGS}" all
	if use static-libs ; then
		pemake \
			-C "${BUILD_DIR}/static" \
			OPT="${CFLAGS}" \
			SHARED="no" \
			lib/libpci.a
	fi
}

src_install() {
	pemake DESTDIR="${D}" install install-lib
	use static-libs && dolib.a "${BUILD_DIR}/static/lib/libpci.a"

	cleanup_install
}
