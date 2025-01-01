# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DocBook XML catalog auto-updater"
HOMEPAGE="https://sources.gentoo.org/gentoo-src/build-docbook-catalog/"
SRC_URI="https://github.com/gentoo/build-docbook-catalog/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="|| ( app-core/util-linux app-var/getopt )
	lib-core/libxml2"

src_prepare() {
	sed -i 's|$(PREFIX)/sbin|$(PREFIX)/bin|' Makefile || die

	default

	sed -i -e "1s@#!@#!${EPREFIX}@" build-docbook-catalog || die
	sed -i -e "/^EPREFIX=/s:=.*:='${EPREFIX}':" build-docbook-catalog || die
	has_version app-core/util-linux || sed -i -e '/^GETOPT=/s/getopt/&-long/' build-docbook-catalog || die
}

src_configure() {
	export MAKEOPTS+=" EPREFIX=${EPREFIX}"

	default
}

pkg_postinst() {
	build-docbook-catalog || die "Failed to regenerate docbook catalog."
}
