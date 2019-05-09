# Distributed under the terms of the GNU General Public License v2

inherit eutils sgml-catalog

MY_P="docbook-${PV}"
DESCRIPTION="Docbook SGML DTD 4.5"
HOMEPAGE="http://docbook.org/sgml/"
SRC_URI="http://www.docbook.org/sgml/${PV}/${MY_P}.zip"

LICENSE="docbook"
SLOT="4.5"
KEYWORDS="amd64 arm64"

IUSE="prefix"

RDEPEND="app-text/sgml-common"

S=${WORKDIR}

sgml-catalog_cat_include "/etc/sgml/sgml-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/sgml-dtd-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook-${PV}.cat" \
	"/etc/sgml/sgml-docbook.cat"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-catalog.diff
}

src_install() {
	insinto /usr/share/sgml/docbook/sgml-dtd-${PV}
	doins *.dcl *.dtd *.mod *.xml || die "doins failed"
	newins docbook.cat catalog || die "newins failed"

	cleanup_install
}
