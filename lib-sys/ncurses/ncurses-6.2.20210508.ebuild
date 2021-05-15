# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN}-$(ver_rs 2 -)"

DESCRIPTION="console display library"
HOMEPAGE="http://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"
SRC_URI="https://invisible-mirror.net/archives/ncurses/current/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--disable-termcap
		--with-terminfo-dirs="${EPREFIX}"/usr/share/terminfo
		--with-pkg-config-libdir="${EPREFIX}"/usr/lib/pkgconfig
		--enable-pc-files
		--without-normal
		--with-symlinks
		--enable-overwrite
		--with-shared
		--without-debug
		--enable-colorfgbg
		--enable-echo
		--enable-widec
		--with-pthread
		--enable-ext-colors
		--without-manpages
		--with-termlib
		--disable-stripping
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	local lib

	for lib in ncurses form panel menu tinfo ; do
    	echo "INPUT(-l${lib}tw)" > "${ED}"/usr/lib/lib${lib}.so
    	echo "INPUT(-l${lib}tw)" > "${ED}"/usr/lib/lib${lib}w.so
    	ln -sfv ${lib}tw.pc        "${ED}"/usr/lib/pkgconfig/${lib}.pc
    	ln -sfv ${lib}tw.pc        "${ED}"/usr/lib/pkgconfig/${lib}w.pc
	done

	echo "INPUT(-lncursestw)" > "${ED}"/usr/lib/libcurses.so

	use static-libs || find "${ED}"/usr/ -name '*.a' -delete
	use static-libs || find "${ED}" -name '*.la' -delete
}
