# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P=${P/opensp/OpenSP}

DESCRIPTION="A free, object-oriented toolkit for SGML parsing and entity management"
HOMEPAGE="http://openjade.sourceforge.net/"
SRC_URI="mirror://sourceforge/openjade/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc nls static-libs test"

DEPEND="doc? (
		app-text/xmlto
		app-text/docbook-xml-dtd
	)
	test? (
		app-text/docbook-xml-dtd
		app-text/openjade
		app-text/sgml-common
	)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	default
	sed -i 's/32,/253,/' lib/Syntax.cxx || die
	sed -i 's/LITLEN          240 /LITLEN          8092/' \
		unicode/{gensyntax.pl,unicode.syn} || die
}

src_configure() {
	local myconf=(
		--enable-http
		--enable-default-catalog="${EPREFIX}"/etc/sgml/catalog
		--enable-default-search-path="${EPREFIX}"/usr/share/sgml
		--datadir="${EPREFIX}"/usr/share/sgml/${P}
		$(use_enable nls)
		$(use_enable doc doc-build)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	emake pkgdocdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_test() {
	# Skipping tests known not to work
	emake SHOWSTOPPERS= check
	SANDBOX_PREDICT="${SANDBOX_PREDICT%:/}"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		pkgdocdir="${EPREFIX}"/usr/share/doc/${PF} \
		install

	cleanup_install
}
