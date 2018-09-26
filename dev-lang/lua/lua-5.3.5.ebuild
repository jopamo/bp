# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils autotools multilib multilib-minimal portability toolchain-funcs versionator

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="5.3"
KEYWORDS="amd64 arm64 x86"

IUSE="+deprecated readline static"

RDEPEND="readline? ( lib-sys/readline:0= )
	app-eselect/eselect-lua
	!dev-lang/lua:0"
DEPEND="${RDEPEND}
	sys-devel/libtool"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/lua${SLOT}/luaconf.h
)

src_prepare() {
	local PATCH_PV=$(get_version_component_range 1-2)

	epatch "${FILESDIR}"/${PN}-${PATCH_PV}-make-r1.patch

	# correct lua versioning
	sed -i -e 's/\(LIB_VERSION = \)6:1:1/\10:0:0/' src/Makefile || die

	sed -i -e 's:\(/README\)\("\):\1.gz\2:g' doc/readme.html || die

	if ! use readline ; then
		sed -i -e '/#define LUA_USE_READLINE/d' src/luaconf.h || die
	fi

	if use static ; then
		sed -i -e 's:\(-export-dynamic\):-static \1:' src/Makefile || die
	fi

	# upstream does not use libtool, but we do (see bug #336167)
	cp "${FILESDIR}/configure.in" "${S}/configure.ac" || die
	eautoreconf

	# custom Makefiles
	multilib_copy_sources

	# A slotted Lua uses different directories for headers & names for
	# libraries, and pkgconfig should reflect that.
	sed -r -i \
		-e "/^Libs:/s,((-llua)($| )),\2${SLOT}\3," \
		-e "/^Cflags:/s,((-I..includedir.)($| )),\2/lua${SLOT}\3," \
		"${S}"/etc/lua.pc
}

multilib_src_configure() {
	sed -i \
		-e 's:\(define LUA_ROOT\s*\).*:\1"'${EPREFIX}'/usr/":' \
		-e "s:\(define LUA_CDIR\s*LUA_ROOT \"\)lib:\1$(get_libdir):" \
		src/luaconf.h \
	|| die "failed patching luaconf.h"

	econf
}

multilib_src_compile() {
	tc-export CC

	# what to link to liblua
	liblibs="-lm"
	liblibs="${liblibs} $(dlopen_lib)"

	# what to link to the executables
	mylibs=
	use readline && mylibs="-lreadline"

	cd src

	local myCFLAGS=""
	use deprecated && myCFLAGS="-DLUA_COMPAT_ALL"

	emake CC="${CC}" CFLAGS="${myCFLAGS} ${CFLAGS}" \
			SYSLDFLAGS="${LDFLAGS}" \
			RPATH="${EPREFIX}/usr/$(get_libdir)/" \
			LUA_LIBS="${mylibs}" \
			LIB_LIBS="${liblibs}" \
			V=$(get_version_component_range 1-2) \
			gentoo_all
}

multilib_src_install() {
	emake INSTALL_TOP="${ED}/usr" INSTALL_LIB="${ED}/usr/$(get_libdir)" \
			V=${SLOT} gentoo_install

	# We want packages to find our things...
	cp "${FILESDIR}/lua.pc" "${WORKDIR}"
	sed -i \
		-e "s:^prefix= :prefix= ${EPREFIX}:" \
		-e "s:^V=.*:V= ${PATCH_PV}:" \
		-e "s:^R=.*:R= ${PV}:" \
		-e "s:/,lib,:/$(get_libdir):g" \
		"${WORKDIR}/lua.pc"

	insinto "/usr/$(get_libdir)/pkgconfig"
	newins "${WORKDIR}/lua.pc" "lua${SLOT}.pc"
}

# Makefile contains a dummy target that doesn't do tests
# but causes issues with slotted lua (bug #510360)
src_test() { :; }
