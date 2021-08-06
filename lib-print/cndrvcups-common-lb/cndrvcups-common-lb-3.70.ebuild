# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

MY_PV="$(ver_rs 1- '')"
SOURCES_NAME="linux-UFRII-drv-v${MY_PV}-uken"

DESCRIPTION="Common files for Canon drivers"
HOMEPAGE="https://www.canon-europe.com/support/products/imagerunner/imagerunner-1730i.aspx"
SRC_URI="http://gdlp01.c-wss.com/gds/8/0100007658/08/${SOURCES_NAME}-05.tar.gz"
S="${WORKDIR}/${SOURCES_NAME}/Sources/${P/-lb-${PV}/-4.10}"

# GPL-2 License inside LICENSE-EN.txt files
LICENSE="Canon-UFR-II GPL-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	x11-live-lib/gtk+:2
	lib-core/libxml2
	xgui-live-lib/glade:2
	lib-print/cups
"

PATCHES=( "${FILESDIR}"/${P}-fno-common.patch )

pkg_setup() {
	# Don't raise a fuss over pre-built binaries
	QA_PREBUILT="
		/usr/libexec/cups/filter/c3pldrv
		/usr/lib/libColorGear.so.0.0.0
		/usr/lib/libColorGearC.so.1.0.0
		/usr/lib/libc3pl.so.0.0.1
		/usr/lib/libcaepcm.so.1.0
		/usr/lib/libcaiousb.so.1.0.0
		/usr/lib/libcaiowrap.so.1.0.0
		/usr/lib/libcanon_slim.so.1.0.0
		/usr/lib/libcanonc3pl.so.1.0.0"
	QA_SONAME="
		/usr/lib/libcaiousb.so.1.0.0"
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${SOURCES_NAME}/Sources/" || die
	unpack ./${P/-lb-${PV}/-4.10}-1.tar.gz
}

change_dir() {
	for i in cngplp buftool backend; do
		cd "${i}" || die
		"${@}" || die
		cd "${S}" || die
	done
}

src_prepare() {
	default
	sed -i -e \
		"s:backenddir = \$(libdir)/cups/backend:backenddir = `cups-config --serverbin`/backend:" \
		backend/Makefile.am || die

	sed -i -e "s@CC=gcc@CC=$(tc-getCC)@" c3plmod_ipc/Makefile || die

	export "LIBS=-lgtk-x11-2.0 -lgobject-2.0 -lglib-2.0 -lgmodule-2.0"
	change_dir mv configure.in configure.ac
	change_dir sed -i -e 's/configure.in/configure.ac/' configure.ac
	change_dir eautoreconf
}

src_configure() {
	change_dir econf
}

src_compile() {
	change_dir emake AR="$(tc-getAR)"

	# Cannot be moved to 'change_dir' as it doesn't need eautoreconf
	cd "${S}/c3plmod_ipc" || die
	emake
}

src_install() {
	MAKEOPTS+=" -j1" default

	cd "${S}/c3plmod_ipc" || die
	dolib.so libcanonc3pl.so.1.0.0
	dosym libcanonc3pl.so.1.0.0 "/usr/lib/libcanonc3pl.so.1"
	dosym libcanonc3pl.so.1.0.0 "/usr/lib/libcanonc3pl.so"

	cd "${S}/data" || die
	insinto /usr/share/caepcm
	doins *

	ABI=x86
	cd "${S}/libs" || die
	exeinto $(cups-config --serverbin)/filter
	doexe c3pldrv
	dolib.so libcaepcm.so.1.0
	dosym libcaepcm.so.1.0 "/usr/lib/libcaepcm.so.1"
	dosym libcaepcm.so.1.0 "/usr/lib/libcaepcm.so"
	for lib in *.so.?.?.?; do
		dolib.so "${lib}"
		dosym "${lib}" "/usr/lib/${lib%.?.?}"
		dosym "${lib}" "/usr/lib/${lib%.?.?.?}"
	done

	# c3pldrv dlopens the absolute path /usr/lib/libc3pl.so :(, bug #????
	# Only needed with SYMLINK_LIB=yes #642138
	if [[ "lib" != lib ]] && [[ ${SYMLINK_LIB} = yes ]]; then
		dosym "../lib/libc3pl.so" /usr/lib/libc3pl.so
	fi

	find "${ED}" -name '*.la' -o -name '*.a' -delete || die
}
