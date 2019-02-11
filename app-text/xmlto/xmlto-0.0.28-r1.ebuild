# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="script for converting XML and DocBook documents to a variety of output formats"
HOMEPAGE="https://pagure.io/xmlto"
SRC_URI="https://releases.pagure.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="latex text"

RDEPEND="app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd
	sys-app/bash:0
	lib-dev/libxslt
	sys-app/sed
	|| ( >=sys-app/coreutils-6.10-r1 sys-freebsd/freebsd-ubin )
	|| ( sys-app/util-linux app-misc/getopt )
	|| ( sys-app/busybox sys-freebsd/freebsd-ubin )
	text? ( app-misc/w3m  )
	latex? ( >=app-text/passivetex-1.25 >=app-text/xmltex-1.9-r2 )"
# We only depend on flex when we patch the imput lexer.
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog FAQ NEWS README THANKS"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.0.22-format_fo_passivetex_check.patch
}

src_configure() {
	# We don't want the script to detect /bin/sh if it is bash.
	export ac_cv_path_BASH=${BASH}
	has_version sys-app/util-linux || export GETOPT=getopt-long
	econf
}
