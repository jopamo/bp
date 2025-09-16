# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Provides useful functions commonly found on BSD systems"
HOMEPAGE="https://libbsd.freedesktop.org/wiki/"

SNAPSHOT=22fddb16f8430d64b82a1ea08602be5e61ac203b
SRC_URI="https://github.com/guillemj/libbsd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-dev/libmd"

src_prepare() {
	sed -i 's/^AC_INIT.*/AC_INIT([libbsd], [${PV}], [bugs@libbsd.example])/' configure.ac || die
	default
	eautoreconf
}

src_configure() {
	filter-flags -flto*

	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}
