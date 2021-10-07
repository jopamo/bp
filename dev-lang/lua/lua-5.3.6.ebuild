# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

PATCHES=( "${FILESDIR}"/liblua.so.patch )

append-flags -ffat-lto-objects
filter-flags -Wl,-z,defs

src_prepare() {
	default
	cp "${FILESDIR}"/lua.pc "${S}"/

	sed -i 's/%VER%/$(ver_cut 1-2)/g' lua.pc
	sed -i 's/%REL%/${PV}/g' lua.pc

	sed -e 's:llua:llua5.3:' -e 's:/include:/include/lua5.3:' -i lua.pc
	sed -r -e '/^LUA_(SO|A|T)=/ s/lua/lua5.3/' -e '/^LUAC_T=/ s/luac/luac5.3/' -i src/Makefile

	sed -i -e "s/-O2\ //g" "src/Makefile" || die
}

src_compile() {
	make MYCFLAGS="${CFLAGS}" MYLDFLAGS="${LDFLAGS}" linux
}

src_install() {
	emake	\
		INSTALL_TOP="${ED}"/usr \
		INSTALL_LIB="${ED}"/usr/lib \
		TO_BIN="lua$(ver_cut 1-2) luac$(ver_cut 1-2)" \
		TO_LIB="liblua$(ver_cut 1-2).so.${PV}" \
		INSTALL_INC="${ED}"/usr/include/lua$(ver_cut 1-2) \
    	INSTALL_MAN="${ED}"/usr/share/man/man1 \
    	install

	insinto "/usr/lib/pkgconfig"
	newins lua.pc lua$(ver_cut 1-2).pc

	for x in liblua$(ver_cut 1-2).so liblua$(ver_cut 1-2).so.$(ver_cut 1-2) ; do
		dosym liblua$(ver_cut 1-2).so.${PV} usr/lib/${x}
	done

	rm -rf "${ED}"/usr/share/man
}
