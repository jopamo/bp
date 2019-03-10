# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="af ca cs da de eo es et eu fr hr id it ja kn ko nb nl pl pt_BR pt ru sl sv uk vi zh_CN zh_HK"
PLOCALES_BACKUP="en"

inherit perl-module l10n

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://po4a.alioth.debian.org"
SRC_URI="https://github.com/mquinson/po4a/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=sys-devel/gettext-0.13
	app-text/openjade
	lib-dev/libxslt
"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd:4.1.2"

src_prepare() {
	local locales_path="${S}/po/bin"
	l10n_find_plocales_changes "${locales_path}" "" ".po"

	my_get_disabled_locales() {
		PERL_RM_FILES=( "${PERL_RM_FILES[@]}" "po/bin/${1}.po" "po/pod/${1}.po" )
	}

	l10n_for_each_disabled_locale_do my_get_disabled_locales

	einfo "Your LINGUAS lists the following languages: ${LINGUAS}"

	perl-module_src_prepare
}
