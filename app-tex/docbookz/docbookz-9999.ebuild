# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Unified DocBook SGML/XML/XSL/xmlto toolchain"
HOMEPAGE="https://gitlab.com/pjo/docbookz"
EGIT_REPO_URI="https://gitlab.com/pjo/docbookz"

LICENSE="GPL-2 BSD docbook FDL-1.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/bash
	app-core/util-linux
	lib-core/libxml2
	lib-core/libxslt
"
DEPEND="${RDEPEND}"
IDEPEND="lib-core/libxml2"

src_configure() {
	local emesonargs=(
		-Dcompat_paths=true
		-Dcompat_tools=true
		-Dinstall_catalogs=true
	)

	meson_src_configure
}

_docbookz_update_xml_catalog() (
	local catalog="${EROOT%/}/etc/xml/catalog"
	local entry="${EPREFIX}/etc/xml/docbook-toolchain/catalog"
	local candidate

	catalog=$(readlink -f -- "${catalog}") || die
	candidate=$(mktemp "${catalog}.XXXXXX") || die
	trap 'rm -f -- "${candidate}"' EXIT

	if [[ -e ${catalog} ]]; then
		cp -p -- "${catalog}" "${candidate}" || die
		xmllint --nonet --xpath \
			'/*[local-name()="catalog" and namespace-uri()="urn:oasis:names:tc:entity:xmlns:xml:catalog"]' \
			"${candidate}" >/dev/null || die "Invalid system XML catalog"
	else
		xmlcatalog --create > "${candidate}" || die
		chmod 0644 "${candidate}" || die
	fi

	xmlcatalog --noout --del "${entry}" "${candidate}" || die
	if [[ ${1} == add ]]; then
		xmlcatalog --noout --add nextCatalog "" "${entry}" "${candidate}" || die
	fi
	mv -fT -- "${candidate}" "${catalog}" || die
)

pkg_postinst() {
	_docbookz_update_xml_catalog add
}

pkg_postrm() {
	[[ -n ${REPLACED_BY_VERSION} ]] && return
	[[ -f ${EROOT%/}/etc/xml/catalog ]] || return 0
	_docbookz_update_xml_catalog remove
}
