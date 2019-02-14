# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

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
		INSTALL_LIB="${ED}"/usr/$(get_libdir) \
    	TO_LIB="liblua.a liblua.so.${PV}" \
    	INSTALL_MAN="${ED}"/usr/share/man/man1 \
    	install

	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${FILESDIR}/lua.pc"
	cd "${ED}"/usr/$(get_libdir)/
	ln -s liblua.so.${PV} liblua.so.5.3
	ln -s liblua.so.${PV} liblua.so
}
