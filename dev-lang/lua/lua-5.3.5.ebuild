# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal multilib

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="+deprecated readline static-libs"

RDEPEND="readline? ( lib-sys/readline:0= )"
DEPEND="${RDEPEND}
	sys-devel/libtool"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/lua/luaconf.h
)

PATCHES=( "${FILESDIR}/lua-makefile.patch" )

src_prepare() {
	if ! use readline ; then
		sed -i -e '/#define LUA_USE_READLINE/d' src/luaconf.h || die
	fi

	default
	multilib_copy_sources
}

multilib_src_configure() { :; }

multilib_src_compile() {
	tc-export CC

	use readline && mylibs="-lreadline"

	cd src

	local myCFLAGS=""
	use deprecated && myCFLAGS="-DLUA_COMPAT_ALL"

	emake CC="${CC}" CFLAGS="${myCFLAGS} ${CFLAGS}" all
}

multilib_src_install() {
	emake \
    INSTALL_LIB="${ED}"/usr/$(get_libdir) \
    INSTALL_TOP="${ED}"/usr \
    INSTALL_MAN="${ED}"/usr/share/man/man1 \
    install

	cp "${FILESDIR}/lua.pc" "${WORKDIR}"

	insinto "/usr/$(get_libdir)/pkgconfig"
	newins "${WORKDIR}/lua.pc" "lua.pc"

	rm -rf "${ED}"/usr/man
}

# Makefile contains a dummy target that doesn't do tests
# but causes issues with slotted lua (bug #510360)
src_test() { :; }
