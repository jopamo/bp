# Distributed under the terms of the GNU General Public License v2

EAPI=8

VER_CUT="$(ver_cut 1-2)"
BRANCH_NAME="v$(ver_cut 1-2)"

inherit flag-o-matic

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SNAPSHOT=934fdd481ced3a9d4a7aaace4479ce889ab23582
SRC_URI="https://github.com/lua/lua/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

append-flags -ffat-lto-objects

src_prepare() {
	rm makefile || die
	default
	cp "${FILESDIR}"/lua.pc "${S}"/
	cp "${FILESDIR}"/src-Makefile "${S}"/Makefile

	sed -i -e "s/VERSION_REPLACE/${VER_CUT}/g" "${S}"/lua.pc || die
	sed -i -e "s/VERSION_REPLACE/${VER_CUT}/g" "${S}"/Makefile || die

	sed -i 's|#define LUA_ROOT "/usr/local/"|#define LUA_ROOT "${EPREFIX}/usr/"|' luaconf.h

}

src_install() {
	dobin lua

	insinto /usr/lib/pkgconfig
	doins lua.pc

	insinto /usr/lib
	doins liblua.so.$(ver_cut 1-2).9

	for x in liblua.so.1 liblua.so.$(ver_cut 1-2) liblua.so ; do
		dosym -r /usr/lib/liblua.so.$(ver_cut 1-2).9 /usr/lib/${x}
	done

	use static-libs || rm -f "${ED}"/usr/lib/liblua.a

	insinto /usr/include
	doins lua.h
	doins luaconf.h
	doins lauxlib.h
	doins lualib.h
}
