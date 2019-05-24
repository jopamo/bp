# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools sgml-catalog flag-o-matic toolchain-funcs libtool

DESCRIPTION="Jade is an implementation of DSSSL for formatting SGML and XML documents"
HOMEPAGE="http://openjade.sourceforge.net"
SRC_URI="mirror://sourceforge/openjade/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="app-text/sgml-common
	>=app-text/opensp-1.5.1"
DEPEND="dev-lang/perl
	${RDEPEND}"

PATCHES=( "${FILESDIR}"/openjade-1.3.2-upstream-1.patch	)

src_prepare() {
	default

	sed -i -e '/getopts/{N;s#&G#g#;s#do .getopts.pl.;##;}' \
       -e '/use POSIX/ause Getopt::Std;' msggen.pl

	elibtoolize
}

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--enable-http
		--enable-default-catalog="${EPREFIX}"/etc/sgml/catalog
		--enable-default-search-path="${EPREFIX}"/usr/share/sgml
		--datadir="${EPREFIX}"/usr/share/sgml/${P}
		$(use_enable static-libs static)
	)
	econf ${myconf[@]}
}

src_compile() {
	unset INCLUDE

	emake -j1 SHELL="${BASH}"
}

src_install() {
	default

	dosym openjade  /usr/bin/jade
	dosym onsgmls   /usr/bin/nsgmls
	dosym osgmlnorm /usr/bin/sgmlnorm
	dosym ospam     /usr/bin/spam
	dosym ospent    /usr/bin/spent
	dosym osx       /usr/bin/sgml2xml

	insinto /usr/share/sgml/${P}/
	doins dsssl/builtins.dsl

	echo 'SYSTEM "builtins.dsl" "builtins.dsl"' > ${ED}/usr/share/sgml/${P}/catalog
	insinto /usr/share/sgml/${P}/dsssl
	doins dsssl/{dsssl.dtd,style-sheet.dtd,fot.dtd}
	newins "${FILESDIR}"/${P}.dsssl-catalog catalog

	insinto /usr/share/sgml/${P}/pubtext
	doins pubtext/*
}

sgml-catalog_cat_include "/etc/sgml/${P}.cat" \
	"/usr/share/sgml/openjade-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/${P}.cat" \
	"/usr/share/sgml/openjade-${PV}/dsssl/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook.cat" \
	"/etc/sgml/${P}.cat"
