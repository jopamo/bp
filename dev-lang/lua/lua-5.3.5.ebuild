# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

PATCHES=( ${FILESDIR}/lua-shared.patch )

src_prepare() {
	default
	sed "s/^R= \$V.4/R= \$V.5/" -i Makefile
}

src_compile() {
	make MYCFLAGS="${CFLAGS} -DLUA_COMPAT_5_2 -DLUA_COMPAT_5_1" MYLDFLAGS="${LDFLAGS}" linux
}

src_install() {
	emake	\
		INSTALL_TOP="${ED}"/usr \
		INSTALL_LIB="${ED}"/usr/lib64 \
    	TO_LIB="liblua.a liblua.so.${PV}" \
    	INSTALL_MAN="${ED}"/usr/share/man/man1 \
    	install

	insinto "/usr/lib64/pkgconfig"
	doins "${FILESDIR}/lua.pc"

	for x in liblua.so.1 liblua.so.$(ver_cut 1-2) liblua.so ; do
		dosym liblua.so.${PV} usr/lib64/${x}
	done

	use static-libs || rm -f "${ED}"/usr/lib64/liblua.a
}
