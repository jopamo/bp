# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit multibuild qmake-utils git-r3

DESCRIPTION="Qt library to start applications only once per user"
HOMEPAGE="https://code.qt.io/cgit/qt-solutions/qt-solutions.git/"
EGIT_REPO_URI="https://code.qt.io/qt-solutions/qt-solutions.git"
S=${WORKDIR}/${P}/${PN}

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="doc +qt5 X"

REQUIRED_USE="qt5"

DEPEND="
	gui-lib/qtlockedfile[qt5?]
	qt5? (
		gui-lib/qtcore:5
		gui-lib/qtnetwork:5
		X? (
			gui-lib/qtgui:5
			gui-lib/qtwidgets:5
		)
	)
"
RDEPEND="${DEPEND}"

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt5) )
}

src_prepare() {
	echo 'SOLUTIONS_LIBRARY = yes' > config.pri
	echo 'QT -= gui' >> src/qtlockedfile.pri

	sed -i -e "s/-head/-${PV%.*}/" common.pri || die
	sed -i -e '/SUBDIRS+=examples/d' ${PN}.pro || die

	multibuild_copy_sources
}

src_configure() {
	multibuild_foreach_variant run_in_build_dir eqmake5
}

src_compile() {
	multibuild_foreach_variant run_in_build_dir default
}

src_install() {
	dodoc README.TXT
	use doc && dodoc -r doc/html

	myinstall() {
		# libraries
		dolib.so lib/*

		# headers
		insinto "$(${MULTIBUILD_VARIANT}_get_headerdir)"/QtSolutions
		doins src/qtsinglecoreapplication.h
		use X && doins src/{QtSingleApplication,${PN}.h}

		# .prf files
		insinto "$(${MULTIBUILD_VARIANT}_get_mkspecsdir)"/features
		doins "${FILESDIR}"/qtsinglecoreapplication.prf
		use X && doins "${FILESDIR}"/${PN}.prf
	}
	multibuild_foreach_variant run_in_build_dir myinstall
}
