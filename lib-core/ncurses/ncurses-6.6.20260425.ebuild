# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="console display library"
HOMEPAGE="https://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"

SNAPSHOT="$(ver_rs 2 -)"
SRC_URI="https://invisible-mirror.net/archives/ncurses/current/ncurses-${SNAPSHOT}.tgz"
S="${WORKDIR}/ncurses-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default

	sed -i 's/for opt in -L$libdir @EXTRA_PKG_LDFLAGS@ @LIBS@/for opt in -L$libdir @LIBS@/' \
		misc/gen-pkgconfig.in
	sed -i 's/for opt in -L$libdir @EXTRA_PKG_LDFLAGS@ $LIBS/for opt in -L$libdir $LIBS/' \
		misc/ncurses-config.in
}

src_configure() {
	qa-policy-configure
	local build_dir="${WORKDIR}/build"
	local build_cflags=${BUILD_CFLAGS:--O2}
	local build_ldflags=${BUILD_LDFLAGS:-}
	local myconf=(
		"--with-build-cflags=${build_cflags}"
		"--with-build-ldflags=${build_ldflags}"
		--disable-big-strings
		--disable-rpath-hack
		--disable-setuid-environ
		--disable-stripping
		--disable-root-access
		--enable-colorfgbg
		--enable-echo
		--enable-ext-colors
		--enable-overwrite
		--enable-pc-files
		--enable-symlinks
		--enable-termcap
		--enable-widec
		--with-cxx-binding
		--with-cxx-shared
		--with-normal
		--with-pkg-config-libdir=/usr/lib/pkgconfig
		--with-profile
		--with-pthread
		--with-shared
		--with-symlinks
		--with-terminfo-dirs=/usr/share/terminfo
		--with-termlib
		--without-debug
		--without-manpages
	)

	mkdir -p "${build_dir}" || die
	cd "${build_dir}" || die
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	local build_dir="${WORKDIR}/build"
	local terminfo_caps="${S}/include/Caps"
	local caplist="${S}/include/Caps ${S}/include/Caps-ncurses"

	# Blow away generated files first.  If one of these was created during a bad
	# partial build (especially hashsize.h), make may otherwise reuse it.
	rm -f \
		"${build_dir}"/include/ncurses_def.h \
		"${build_dir}"/include/hashsize.h \
		"${build_dir}"/include/term.h \
		"${build_dir}"/include/curses.h \
		"${build_dir}"/ncurses/comp_captab.c \
		"${build_dir}"/ncurses/comp_userdefs.c \
		"${build_dir}"/ncurses/names.c \
		"${build_dir}"/ncurses/codes.c \
		"${build_dir}"/ncurses/lib_keyname.c \
		"${build_dir}"/ncurses/unctrl.c \
		"${build_dir}"/ncurses/init_keytry.h || die

	# Generate headers/tables explicitly before the parallel build.  The top-level
	# "sources" target is not enough here; we need the include/ headers and the
	# ncurses/ generated sources in a known-good order.
	emake -C "${build_dir}"/include -j1 TERMINFO_CAPS="${terminfo_caps}" CAPLIST="${caplist}" \
		ncurses_def.h hashsize.h term.h curses.h
	emake -C "${build_dir}"/ncurses -j1 TERMINFO_CAPS="${terminfo_caps}" CAPLIST="${caplist}" \
		make_hash make_keys keys.list \
		comp_captab.c comp_userdefs.c names.c codes.c lib_keyname.c \
		unctrl.c init_keytry.h
	emake -C "${build_dir}" TERMINFO_CAPS="${terminfo_caps}" CAPLIST="${caplist}"
}

src_install() {
	local build_dir="${WORKDIR}/build"
	emake -C "${build_dir}" DESTDIR="${D}" install

	local lib
	for lib in ncurses "ncurses++" form panel menu tinfo; do
		printf '/* GNU ld script */\nINPUT(-l%stw)\n' "${lib}" > "${ED}"/usr/lib/lib${lib}.so
		printf '/* GNU ld script */\nINPUT(-l%stw)\n' "${lib}" > "${ED}"/usr/lib/lib${lib}w.so
		dosym -r /usr/lib/pkgconfig/${lib}tw.pc /usr/lib/pkgconfig/${lib}.pc
		dosym -r /usr/lib/pkgconfig/${lib}tw.pc /usr/lib/pkgconfig/${lib}w.pc
	done

	printf '/* GNU ld script */\nINPUT(-lncursestw)\n' > "${ED}"/usr/lib/libcurses.so

	use static-libs || find "${ED}"/usr -name '*.a' -delete
	use static-libs || find "${ED}" -name '*.la' -delete

	qa-policy-install "${ED}"/usr
}
