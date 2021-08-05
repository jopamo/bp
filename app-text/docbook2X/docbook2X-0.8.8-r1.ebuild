# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Tools to convert docbook to man and info"
SRC_URI="mirror://sourceforge/docbook2x/${P}.tar.gz"
HOMEPAGE="http://docbook2x.sourceforge.net/"

SLOT="0"
KEYWORDS="amd64 arm64"
LICENSE="MIT"

IUSE="test"

DEPEND="dev-perl/XML-SAX-Base
	lib-core/libxslt
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd"

PATCHES=(
	"${FILESDIR}"/01_fix_static_datadir_evaluation.patch
	"${FILESDIR}"/02_fix_418703_dont_use_abbreviated_sfnet_address.patch
	"${FILESDIR}"/03_fix_420153_filename_whitespace_handling.patch
	"${FILESDIR}"/04_fix_442782_preprocessor_declaration_syntax.patch
	"${FILESDIR}"/05_fix_439214_error_on_missing_refentry.patch
	"${FILESDIR}"/06_fix_man_typo.patch
)

src_prepare() {
	sed -i -e 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/' configure.ac || die 'sed on configure.ac failed'
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
		--with-xslt-processor=libxslt
		--program-transform-name='/^docbook2/s,$,.pl,'
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	dosym docbook2man.pl /usr/bin/docbook2x-man
	dosym docbook2texi.pl /usr/bin/docbook2x-texi
}
