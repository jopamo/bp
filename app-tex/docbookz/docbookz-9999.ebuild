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

src_configure() {
	local emesonargs=(
		-Dcompat_paths=true
		-Dcompat_tools=true
		-Dinstall_catalogs=true
	)

	meson_src_configure
}
