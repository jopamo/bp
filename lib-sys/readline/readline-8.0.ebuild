# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Another cute console display library"
HOMEPAGE="https://tiswww.case.edu/php/chet/readline/rltop.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/8"  # subslot matches SONAME major
KEYWORDS="amd64 arm64"

IUSE="static-libs utils"

DEPEND=">=lib-sys/ncurses-5.9-r3:0=[static-libs?]
	dev-util/pkgconf"

PATCHES=( 	"${FILESDIR}"/${PN}-5.0-no_rpath.patch
			"${FILESDIR}"/${PN}-6.2-rlfe-tgoto.patch
			"${FILESDIR}"/${PN}-7.0-headers.patch
		)

src_prepare() {
	default
	# Force ncurses linking and use pkg-config to get the right values.
	local ncurses_libs=$($(tc-getPKG_CONFIG) ncurses --libs)
	sed -i \
		-e "/^SHLIB_LIBS=/s:=.*:='${ncurses_libs}':" \
		support/shobj-conf || die
	sed -i \
		-e "/^[[:space:]]*LIBS=.-lncurses/s:-lncurses:${ncurses_libs}:" \
		examples/rlfe/configure || die
}

src_configure() {
	# fix implicit decls with widechar funcs
	append-cppflags -D_GNU_SOURCE
	# https://lists.gnu.org/archive/html/bug-readline/2010-07/msg00013.html
	append-cppflags -Dxrealloc=_rl_realloc -Dxmalloc=_rl_malloc -Dxfree=_rl_free

	# Make sure configure picks a better ar than `ar`. #484866
	export ac_cv_prog_AR=$(tc-getAR)

	# Force the test since we used sed above to force it.
	export bash_cv_termcap_lib=ncurses

	# Control cross-compiling cases when we know the right answer.
	# In cases where the C library doesn't support wide characters, readline
	# itself won't work correctly, so forcing the answer below should be OK.
	if tc-is-cross-compiler ; then
		export bash_cv_func_sigsetjmp='present'
		export bash_cv_func_ctype_nonascii='yes'
		export bash_cv_wcwidth_broken='no' #503312
	fi

	# This is for rlfe, but we need to make sure LDFLAGS doesn't change
	# so we can re-use the config cache file between the two.
	append-ldflags -L.

	default
}

src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--cache-file="${BUILD_DIR}"/config.cache \
		--docdir='$(datarootdir)'/doc/${PF} \
		--with-curses \
		$(use_enable static-libs static)

	if use utils ; then
		# code is full of AC_TRY_RUN()
		mkdir -p examples/rlfe || die
		cd examples/rlfe || die
		ECONF_SOURCE=${S}/examples/rlfe \
		econf --cache-file="${BUILD_DIR}"/config.cache
	fi
}

src_compile() {
	emake

	if use utils ; then
		# code is full of AC_TRY_RUN()
		cd examples/rlfe || die
		local l
		for l in readline history ; do
			ln -s ../../shlib/lib${l}$(get_libname)* lib${l}$(get_libname)
			ln -sf ../../lib${l}.a lib${l}.a
		done
		emake
	fi
}
