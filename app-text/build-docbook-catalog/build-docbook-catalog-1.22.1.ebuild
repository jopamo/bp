# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DocBook XML catalog auto-updater"
HOMEPAGE="https://sources.gentoo.org/gentoo-src/build-docbook-catalog/"
SRC_URI="https://github.com/somasis/build-docbook-catalog/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="|| ( app-core/util-linux app-var/getopt )
	lib-core/libxml2"

pkg_setup() {
	# export for bug #490754
	export MAKEOPTS+=" prefix=${EPREFIX} bindir=${EPREFIX}/usr/bin"
}

src_prepare() {
	default
	sed -i -e "/^EPREFIX=/s:=.*:='${EPREFIX}':" build-docbook-catalog.in || die
	has_version app-core/util-linux || sed -i -e '/^GETOPT=/s/getopt/&-long/' build-docbook-catalog.in || die
}

pkg_postinst() {
	# New version -> regen files
	build-docbook-catalog
}
