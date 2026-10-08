# Distributed under the terms of the GNU General Public License v2

VER_CUT="$(ver_cut 1-2)"
BRANCH_NAME="v${VER_CUT}"
inherit flag-o-matic qa-policy

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SNAPSHOT=312b9efaa1061c2c4cad08554dbc1351c3270eef
SRC_URI="https://github.com/lua/lua/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="!app-lang/lua:5.5"

src_prepare() {
	qa-policy-configure
	append-cflags -DLUA_USE_LINUX -fPIC
	rm makefile || die
	default
	cp "${FILESDIR}"/lua.pc "${S}"/
	cp "${FILESDIR}"/src-Makefile "${S}"/Makefile

	sed -i -e "s/VERSION_REPLACE/${VER_CUT}/g" "${S}"/lua.pc || die
	sed -i -e "s/VERSION_REPLACE/${VER_CUT}/g" -e "s/^R = .*/R = ${PV}/" "${S}"/Makefile || die

	sed -i "s|\"/usr/local/\"|\"${EPREFIX}/usr/\"|" luaconf.h || die
}

src_install() {
	dobin lua

	insinto /usr/lib/pkgconfig
	doins lua.pc

	insinto /usr/lib
	doins liblua.so.${PV}
	use static-libs && doins liblua.a

	for x in liblua.so.1 liblua.so.$(ver_cut 1-2) liblua.so ; do
		dosym -r /usr/lib/liblua.so.${PV} /usr/lib/${x}
	done

	insinto /usr/include
	doins lua.h
	doins luaconf.h
	doins lauxlib.h
	doins lualib.h
	doins "${FILESDIR}/lua.hpp"

	qa-policy-install
}
