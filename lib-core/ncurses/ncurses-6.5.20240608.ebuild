# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="ncurses-$(ver_rs 2 -)"

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

	local i

	for i in ncurses form panel menu tinfo ; do
    	echo "INPUT(-l${i}tw)" > "${ED}"/usr/lib/lib${i}.so
    	echo "INPUT(-l${i}tw)" > "${ED}"/usr/lib/lib${i}w.so
    	dosym -r /usr/lib/pkgconfig/${i}tw.pc /usr/lib/pkgconfig/${i}.pc
    	dosym -r /usr/lib/pkgconfig/${i}tw.pc /usr/lib/pkgconfig/${i}w.pc
    done

	echo "INPUT(-lncursestw)" > "${ED}"/usr/lib/libcurses.so

	use static-libs || find "${ED}"/usr/ -name '*.a' -delete
	use static-libs || find "${ED}" -name '*.la' -delete
}
