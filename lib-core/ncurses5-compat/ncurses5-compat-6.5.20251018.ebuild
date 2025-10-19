# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

DESCRIPTION="console display library"
HOMEPAGE="http://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"
SNAPSHOT=27bdf816cb98ead8c749ca4535ff888af5cd279e
SRC_URI="https://github.com/ThomasDickey/ncurses-snapshots/archive/${SNAPSHOT}.tar.gz -> ncurses-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ncurses-snapshots-${SNAPSHOT}"

MY_P="ncurses-$(ver_rs 2 -)"

SRC_URI="https://invisible-mirror.net/archives/ncurses/current/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local myconf=(
		--disable-stripping
		--enable-widec
		--with-normal
		--with-shared
		--with-terminfo-dirs="${EPREFIX}"/usr/share/terminfo
		--without-ada
		--without-debug
  		--disable-pc-files
   		--with-abi-version=5
   		--with-cxx-binding
   		--with-cxx-shared
   		--with-versioned-syms
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	mkdir -p "${ED}"/usr/lib/
	cp "${S}"/lib/lib*5* "${ED}"/usr/lib/

	local i

	for i in ncurses form panel menu ncurses++ ; do
		cd "${ED}"/usr/lib
		rm lib${i}w.so.5
		ln -s lib${i}w.so.5.9 lib${i}w.so.5
	done

	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so.5
  	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libtic.so.5
  	dosym -r /usr/lib/libncursesw.so.5.9 /usr/lib/libncurses.so.5
}
