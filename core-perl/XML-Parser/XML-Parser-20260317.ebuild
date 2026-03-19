# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module flag-o-matic qa-policy

DESCRIPTION="A perl module for parsing XML documents"
HOMEPAGE="https://metacpan.org/release/XML-Parser"
SNAPSHOT=fc71e31df91ddedde919f97e2bc79ec40d05e5d6
SRC_URI="https://github.com/cpan-authors/XML-Parser/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}"/${P}-drop-sharedir-deps.patch )

DEPEND+="
	lib-core/expat
"
RDEPEND+="
	lib-core/expat
"

src_configure() {
	filter-flags -Wl,-z,defs
	qa-policy-configure

	local myconf=(
		"EXPATLIBPATH=${EPREFIX}/usr/lib"
		"EXPATINCPATH=${EPREFIX}/usr/include"
	)
	perl-module_src_configure
}

src_install() {
	perl-module_src_install

	insinto "$(perl_get_vendorlib)/XML/Parser/Encodings"
	doins Parser/Encodings/README Parser/Encodings/Japanese_Encodings.msg share/*.enc

	qa-policy-install
}
