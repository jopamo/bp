# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils autotools multilib multilib-minimal portability toolchain-funcs versionator flag-o-matic

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="5.3"
KEYWORDS="amd64 arm64 x86"
IUSE="static"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/luaconf.h
)

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	local PATCH_PV=$(get_version_component_range 1-2)

	epatch "${FILESDIR}"/${PN}-makefile.patch

	# Using dynamic linked lua is not recommended for performance
	# reasons. http://article.gmane.org/gmane.comp.lang.lua.general/18519
	# Mainly, this is of concern if your arch is poor with GPRs, like x86
	# Note that this only affects the interpreter binary (named lua), not the lua
	# compiler (built statically) nor the lua libraries (both shared and static
	# are installed)
	if use static ; then
		sed -i -e 's:\(-export-dynamic\):-static \1:' src/Makefile || die
	fi

	# upstream does not use libtool, but we do (see bug #336167)
	cp "${FILESDIR}/configure.in" "${S}/configure.ac" || die
	eautoreconf

	# custom Makefiles
	multilib_copy_sources
}

multilib_src_compile() {
	tc-export CC

	local mylibs="-lm -lreadline"
	local myCFLAGS="-DLUA_USE_LINUX -DLUA_COMPAT_5_2 -DLUA_COMPAT_5_1"

	cd src

	emake CC="${CC}" CFLAGS="${myCFLAGS} ${CFLAGS}" \
			SYSLDFLAGS="${LDFLAGS}" \
			RPATH="${EPREFIX}"/usr/$(get_libdir)/ \
			LUA_LIBS="${mylibs}" \
			LIB_LIBS="${liblibs}" \
			V=$(get_version_component_range 1-2) \
			linux
}

multilib_src_install() {
	emake \
	INSTALL_TOP="${ED}"usr \
    INSTALL_DATA='cp -d' \
    INSTALL_TOP="${EPREFIX}"usr \
    INSTALL_MAN="${EPREFIX}"usr/share/man/man1 \
    install

	cp "${FILESDIR}/lua.pc" "${WORKDIR}"

	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${WORKDIR}/lua.pc"
}

multilib_src_install_all() {
	dodoc README
	dohtml doc/*.html doc/*.png doc/*.css doc/*.gif
	die
}

# Makefile contains a dummy target that doesn't do tests
# but causes issues with slotted lua (bug #510360)
src_test() { :; }
