# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="DocBook XML catalog auto-updater"
HOMEPAGE="https://sources.gentoo.org/gentoo-src/build-docbook-catalog/"
SRC_URI="https://github.com/somasis/build-docbook-catalog/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="|| ( sys-app/util-linux app-misc/getopt )
	!<app-text/docbook-xsl-stylesheets-1.73.1
	lib-dev/libxml2"
DEPEND=""

pkg_setup() {
	# export for bug #490754
	export MAKEOPTS+=" prefix=${EPREFIX} bindir=${EPREFIX}/usr/bin"
}

src_prepare() {
	sed -i -e "/^EPREFIX=/s:=.*:='${EPREFIX}':" build-docbook-catalog.in || die
	has_version sys-app/util-linux || sed -i -e '/^GETOPT=/s/getopt/&-long/' build-docbook-catalog.in || die
}

pkg_postinst() {
	# New version -> regen files
	build-docbook-catalog
}
