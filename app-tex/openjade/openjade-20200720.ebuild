# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic sgml-catalog-r1 toolchain-funcs

DESCRIPTION="Jade is an implementation of DSSSL for formatting SGML and XML documents"
HOMEPAGE="http://openjade.sourceforge.net"

SNAPSHOT=e804ff522ff4ecc94997d8bed581120e61f6d3eb
SRC_URI="https://1g4.org/files/${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-tex/sgml-common
	>=app-tex/opensp-1.5.1
"
DEPEND="${RDEPEND}
	app-lang/perl
"

src_configure() {
	local myconf=(
		--enable-http
		--enable-default-catalog="${EPREFIX}"/etc/sgml/catalog
		--enable-default-search-path="${EPREFIX}"/usr/share/sgml
		--enable-splibdir="${EPREFIX}"/usr/lib
		--libdir="${EPREFIX}"/usr/lib
		--datadir="${EPREFIX}"/usr/share/sgml/${P}
		--disable-static
	)
	CONFIG_SHELL="${CONFIG_SHELL:-${BASH}}" ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	emake SHELL="${BASH}"
}

src_install() {
	make DESTDIR="${D}" \
		SHELL="${BASH}" \
		install install-man

	cleanup_install

	dosym openjade /usr/bin/jade
	dosym onsgmls /usr/bin/nsgmls
	dosym osgmlnorm /usr/bin/sgmlnorm
	dosym ospam /usr/bin/spam
	dosym ospent /usr/bin/spent
	dosym osx /usr/bin/sgml2xml

	insinto /usr/share/sgml/${P}
	doins dsssl/builtins.dsl

	newins - catalog <<-EOF
		SYSTEM "builtins.dsl" "builtins.dsl"
	EOF
	doins -r pubtext
	insinto /usr/share/sgml/${P}/dsssl
	doins dsssl/{dsssl.dtd,style-sheet.dtd,fot.dtd}
	newins ${PN}.dsssl-catalog catalog

	# Breaks sgml2xml among other things
	#insinto /usr/share/sgml/${P}/unicode
	#doins unicode/{catalog,unicode.sd,unicode.syn,gensyntax.pl}

	insinto /etc/sgml
	newins - "${P}.cat" <<-EOF
		CATALOG "${EPREFIX}/usr/share/sgml/openjade-${PV}/catalog"
		CATALOG "${EPREFIX}/usr/share/sgml/openjade-${PV}/dsssl/catalog"
	EOF
}

pkg_preinst() {
	# work-around old revision removing it
	cp "${ED}"/etc/sgml/${P}.cat "${T}" || die
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
