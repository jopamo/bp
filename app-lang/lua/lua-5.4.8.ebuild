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

PATCHES=( ${FILESDIR}/lua-shared.patch )

append-flags -ffat-lto-objects

src_prepare() {
	default
	cp "${FILESDIR}"/lua.pc "${S}"/

	sed -i -e "s/VERSION_REPLACE/${PV}/g" "${S}"/lua.pc || die

	sed -i -e "s/-O2\ //g" "src/Makefile" || die
	sed -i "s|gcc|cc|g" "src/Makefile" || die
}

src_compile() {
	make MYCFLAGS="${CFLAGS} -DLUA_COMPAT_5_3 -DLUA_COMPAT_5_2 -DLUA_COMPAT_5_1" MYLDFLAGS="${LDFLAGS}" linux
}

src_install() {
	emake	\
		INSTALL_TOP="${ED}"/usr \
		INSTALL_LIB="${ED}"/usr/lib \
    	TO_LIB="liblua.a liblua.so.${PV}" \
    	INSTALL_MAN="${ED}"/usr/share/man/man1 \
    	install

	insinto /usr/lib/pkgconfig
	doins lua.pc

	for x in liblua.so.1 liblua.so.$(ver_cut 1-2) liblua.so ; do
		dosym liblua.so.${PV} usr/lib/${x}
	done

	use static-libs || rm -f "${ED}"/usr/lib/liblua.a
	die
}
