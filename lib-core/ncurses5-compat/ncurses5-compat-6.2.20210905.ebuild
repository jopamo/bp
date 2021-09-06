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
		--with-shared
		--with-normal
		--without-debug
		--without-ada
		--enable-widec
  		--disable-pc-files
   		--with-cxx-binding
   		--with-cxx-shared
   		--with-abi-version=5
		--with-terminfo-dirs="${EPREFIX}"/usr/share/terminfo
		--disable-stripping
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm -rf "${ED}"/usr/{share,include,bin} \
		"${ED}"/usr/lib/ \
		{libformw.so,libmenuw.so,libncursesw.so,libpanelw.so,pkgconfig,terminfo} || die

	local i

	for i in ncurses form panel menu ; do
		dosym -r /usr/lib/lib${i}w.so.5.9 /usr/lib/lib${i}.so.5
	done

	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so.5
  	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libtic.so.5

	use static-libs || find "${ED}"/usr/ -name '*.a' -delete
	use static-libs || find "${ED}" -name '*.la' -delete
}
