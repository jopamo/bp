# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dot-a

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
	use static-libs && lto-guarantee-fat

	local myconf=(
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

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	use static-libs && strip-lto-bytecode "${ED}"/usr

	local lib
	for lib in ncurses "ncurses++" form panel menu tinfo; do
		echo "INPUT(-l${lib}tw)" > "${ED}"/usr/lib/lib${lib}.so
		echo "INPUT(-l${lib}tw)" > "${ED}"/usr/lib/lib${lib}w.so
		dosym -r /usr/lib/pkgconfig/${lib}tw.pc /usr/lib/pkgconfig/${lib}.pc
		dosym -r /usr/lib/pkgconfig/${lib}tw.pc /usr/lib/pkgconfig/${lib}w.pc
	done

	echo "INPUT(-lncursestw)" > "${ED}"/usr/lib/libcurses.so

	use static-libs || find "${ED}"/usr -name '*.a' -delete
	use static-libs || find "${ED}" -name '*.la' -delete
}
