# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="console display library"
HOMEPAGE="http://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"

MY_P="ncurses-$(ver_rs 2 -)"
SRC_URI="https://invisible-mirror.net/archives/ncurses/current/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

PATCHES=(
	"${FILESDIR}/ncurses-6.0-unified.patch"
)

src_configure() {
	unset TERMINFO #115036
	tc-export_build_env BUILD_{CC,CPP}
	BUILD_CPPFLAGS+=" -D_GNU_SOURCE" #214642

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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm -rf "${ED}"/usr/{share,include,bin} "${ED}"/usr/lib/pkgconfig "${ED}"/usr/lib/{libformw.so,libmenuw.so,libncursesw.so,libpanelw.so,terminfo}

	local x

	for x in ncurses form panel menu ; do
		dosym lib${x}w.so.5.9 usr/lib/lib${x}.so.5
	done

	dosym /usr/lib/libncursesw.so.5.9 usr/lib/libtinfo.so.5
  	dosym /usr/lib/libncursesw.so.5.9 usr/lib/libtic.so.5


	use static-libs || find "${ED}"/usr/ -name '*.a' -delete
	use static-libs || find "${ED}" -name '*.la' -delete
}
