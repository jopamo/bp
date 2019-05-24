# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=${P/opensp/OpenSP}

DESCRIPTION="A free, object-oriented toolkit for SGML parsing and entity management"
HOMEPAGE="http://openjade.sourceforge.net/"
SRC_URI="mirror://sourceforge/openjade/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0/1"
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

PATCHES=( "${FILESDIR}"/${P}-fix-segfault.patch )

src_configure() {
	econf \
		--enable-http \
		--enable-default-catalog="${EPREFIX}"/etc/sgml/catalog \
		--enable-default-search-path="${EPREFIX}"/usr/share/sgml \
		--datadir="${EPREFIX}"/usr/share/sgml/${P} \
		$(use_enable nls) \
		$(use_enable doc doc-build) \
		$(use_enable static-libs static)
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
