# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Legacy library for PPD files, split out of cups-filters"
HOMEPAGE="https://github.com/OpenPrinting/libppd"
SRC_URI="https://github.com/OpenPrinting/libppd/releases/download/${PV}/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+postscript +poppler"
KEYWORDS="amd64 arm arm64 ~hppa ~ia64 ~loong ppc ppc64 ~riscv sparc x86"

# pdftops has various possible implementations, but the default
# really needs to be decent
REQUIRED_USE="|| ( postscript poppler )"

RDEPEND="
	lib-print/libcupsfilters
	postscript? ( app-tex/ghostscript-gpl )
	poppler? ( app-tex/poppler )
"
DEPEND="${RDEPEND}"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--localstatedir="${EPREFIX}"/var
		--with-cups-rundir="${EPREFIX}"/run/cups
		$(use_enable postscript ghostscript)
		$(use_enable poppler pdftops)
		--with-mutool-path="${EPREFIX}"/usr/bin/mutool
		--with-pdftocairo-path="${EPREFIX}"/usr/bin/pdftocairo # from poppler
		--disable-acroread
	)

	econf "${myeconfargs[@]}"
}
