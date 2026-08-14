# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic qa-policy

DESCRIPTION="Legacy library for PPD files, split out of cups-filters"
HOMEPAGE="https://github.com/OpenPrinting/libppd"
SNAPSHOT=fc41539f761286396a7df8aeeda762070192e37e
SRC_URI="https://github.com/OpenPrinting/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="postscript poppler"

# pdftops has various possible implementations, but the default
# really needs to be decent


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

	qa-policy-configure
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	qa-policy-install
}
