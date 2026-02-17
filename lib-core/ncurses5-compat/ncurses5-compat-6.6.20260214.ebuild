# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="console display library"
HOMEPAGE="https://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"

SNAPSHOT="$(ver_rs 2 -)"
SRC_URI="https://invisible-mirror.net/archives/ncurses/current/ncurses-${SNAPSHOT}.tgz"
S="${WORKDIR}/ncurses-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local myconf=(
		--disable-pc-files
		--disable-stripping
		--enable-widec
		--with-abi-version=5
		--with-cxx-binding
		--with-cxx-shared
		--with-normal
		--with-shared
		--with-terminfo-dirs=/usr/share/terminfo
		--with-versioned-syms
		--without-ada
		--without-debug
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	mkdir -p "${ED}"/usr/lib || die
	cp "${S}"/lib/lib*5* "${ED}"/usr/lib/ || die

	local lib
	for lib in ncurses form panel menu "ncurses++"; do
		cd "${ED}"/usr/lib || die
		rm lib${lib}w.so.5 || die
		ln -s lib${lib}w.so.5.9 lib${lib}w.so.5 || die
	done

	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so.5
	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libtic.so.5
	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libncurses.so.5
}
