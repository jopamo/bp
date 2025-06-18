# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="script for converting XML and DocBook documents to a variety of output formats"
HOMEPAGE="https://pagure.io/xmlto"
SRC_URI="https://releases.pagure.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-tex/docbook-xsl-stylesheets
	app-tex/docbook-xml-dtd
	lib-core/libxslt
"

PATCHES=( "${FILESDIR}"/${PN}-0.0.22-format_fo_passivetex_check.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# We don't want the script to detect /bin/sh if it is bash.
	export ac_cv_path_BASH=${BASH}
	has_version app-core/util-linux || export GETOPT=getopt-long
	econf
}
