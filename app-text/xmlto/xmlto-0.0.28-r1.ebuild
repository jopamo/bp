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
	text? ( app-misc/lynx  )"


src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.0.22-format_fo_passivetex_check.patch
}

src_configure() {
	# We don't want the script to detect /bin/sh if it is bash.
	export ac_cv_path_BASH=${BASH}
	has_version sys-app/util-linux || export GETOPT=getopt-long
	econf
}
