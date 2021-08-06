# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

MY_PV="$(ver_rs 1- '')"
SOURCES_NAME="linux-UFRII-drv-v${MY_PV}-uken"

DESCRIPTION="Canon UFR II / LIPSLX Printer Driver for Linux"
HOMEPAGE="https://www.canon-europe.com/support/products/imagerunner/imagerunner-1730i.aspx"
SRC_URI="http://gdlp01.c-wss.com/gds/8/0100007658/08/${SOURCES_NAME}-05.tar.gz"
S="${WORKDIR}/${SOURCES_NAME}/Sources/${P}"

LICENSE="Canon-UFR-II"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	x11-live-libs/gtk+:3
	lib-core/libxml2
	lib-gui/glade:2
	lib-print/cups
	~lib-print/cndrvcups-common-lb-${PV}
"

MAKEOPTS+=" -j1"

filter-flags -Wl,-z,defs

pkg_setup() {
	# Don't raise a fuss over pre-built binaries
	QA_PREBUILT="
		/usr/bin/cnpkbidi
		/usr/bin/cnpkmoduleufr2
		/usr/lib/libEnoJPEG.so.1.0.0
		/usr/lib/libEnoJBIG.so.1.0.0
		/usr/lib/libufr2filter.so.1.0.0
		/usr/lib/libcnlbcm.so.1.0
		/usr/lib/libcaiocnpkbidi.so.1.0.0
		/usr/lib/libcanonufr2.so.1.0.0
	"
	QA_SONAME="/usr/lib/libcaiocnpkbidi.so.1.0.0"
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${SOURCES_NAME}/Sources/" || die
	unpack ./${P}-1.tar.gz
}

change_dir() {
	for i in buftool pstoufr2cpca cngplp cngplp/files cpca ; do
		cd "${i}" || die
		"${@}" || die
		cd "${S}" || die
	done
}

src_prepare() {
	default
	sed -i -e \
		"s:filterdir = \lib/cups/filter:filterdir = `cups-config --serverbin`/filter:" \
		pstoufr2cpca/filter/Makefile.am || die

	export "LIBS=-lgmodule-2.0"
	change_dir mv configure.in configure.ac
	change_dir sed -i -e 's/configure.in/configure.ac/' configure.ac
	change_dir eautoreconf
}

src_configure() {
	change_dir econf
}

src_install() {
	default

	insinto /usr/share/cups/model
	doins ppd/*.ppd

	cd "${S}/data" || die
	insinto /usr/share/caepcm
	doins *

	cd "${S}/libs" || die
	insinto /usr/share/cnpkbidi
	doins cnpkbidi_info*

	insinto /usr/share/ufr2filter
	doins ThLB*

	ABI=x86
	dobin cnpkbidi cnpkmoduleufr2
	dolib.so libcnlbcm.so.1.0
	dosym libcnlbcm.so.1.0 "/usr/lib/libcnlbcm.so.1"
	dosym libcnlbcm.so.1.0 "/usr/lib/libcnlbcm.so"
	for lib in *.so.?.?.?; do
		dolib.so "${lib}"
		dosym "${lib}" "/usr/lib/${lib%.?.?}"
		dosym "${lib}" "/usr/lib/${lib%.?.?.?}"
	done

	# c3pldrv dlopens the absolute path /usr/lib/libcnlbcm.so :(, bug #????
	# Only needed with SYMLINK_LIB=yes #642138
	if [[ "lib" != lib ]] && [[ ${SYMLINK_LIB} = yes ]]; then
		dosym "../lib/libcnlbcm.so" /usr/lib/libcnlbcm.so
	fi
}
