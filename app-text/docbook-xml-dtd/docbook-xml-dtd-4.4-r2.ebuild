# Distributed under the terms of the GNU General Public License v2

inherit sgml-catalog

MY_P=${P/-dtd/}
DESCRIPTION="Docbook DTD for XML"
HOMEPAGE="http://www.docbook.org/"
SRC_URI="http://www.docbook.org/xml/${PV}/${MY_P}.zip"

LICENSE="docbook"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
IUSE="prefix"

RDEPEND=">=app-text/docbook-xsl-stylesheets-1.65
	>=app-text/build-docbook-catalog-1.2"

sgml-catalog_cat_include "/etc/sgml/xml-docbook-${PV}.cat" \
	"/etc/sgml/sgml-docbook.cat"
sgml-catalog_cat_include "/etc/sgml/xml-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/xml-dtd-${PV}/docbook.cat"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	# Prepend OVERRIDE directive
	sed -i -e '1i\\OVERRIDE YES' docbook.cat
}

src_install() {
	keepdir /etc/xml

	insinto /usr/share/sgml/docbook/xml-dtd-${PV}
	doins *.cat *.dtd *.mod *.xml || die
	insinto /usr/share/sgml/docbook/xml-dtd-${PV}/ent
	doins ent/*.ent || die

	# work around unicode parser issues #238785
	dosym ../../../xml-iso-entities-8879.1986/ISOgrk4.ent \
		/usr/share/sgml/docbook/xml-dtd-${PV}/ent/isogrk4.ent || die

	cleanup_install
}

pkg_postinst() {
	build-docbook-catalog
	sgml-catalog_pkg_postinst
}

pkg_postrm() {
	build-docbook-catalog
	sgml-catalog_pkg_postrm
}
