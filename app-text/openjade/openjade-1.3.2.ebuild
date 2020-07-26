# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit sgml-catalog-r1 flag-o-matic toolchain-funcs libtool

DESCRIPTION="Jade is an implementation of DSSSL for formatting SGML and XML documents"
HOMEPAGE="http://openjade.sourceforge.net"
SRC_URI="mirror://sourceforge/openjade/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
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

pkg_postinst() {
	local backup=${T}/${P}.cat
	local real=${EROOT}/etc/sgml/${P}.cat
	if ! cmp -s "${backup}" "${real}"; then
		cp "${backup}" "${real}" || die
	fi
	# this one's shared with docbook-dsssl, so we need to do it in postinst
	if ! grep -q -s ${P}.cat \
			"${EROOT}"/etc/sgml/sgml-docbook.cat; then
		ebegin "Adding ${P}.cat to /etc/sgml/sgml-docbook.cat"
		cat >> "${EROOT}"/etc/sgml/sgml-docbook.cat <<-EOF
			CATALOG "${EPREFIX}/etc/sgml/${P}.cat"
		EOF
		eend ${?}
	fi
	sgml-catalog-r1_pkg_postinst
}

pkg_postrm() {
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		ebegin "Removing ${P}.cat from /etc/sgml/sgml-docbook.cat"
		sed -i -e '/${P}/d' \
			"${EROOT}"/etc/sgml/sgml-docbook.cat
		eend ${?}
		if [[ ! -s ${EROOT}/etc/sgml/sgml-docbook.cat ]]; then
			rm -f "${EROOT}"/etc/sgml/sgml-docbook.cat
		fi
	fi
	sgml-catalog-r1_pkg_postrm
}
