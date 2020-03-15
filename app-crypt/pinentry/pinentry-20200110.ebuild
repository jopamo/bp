# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=971d1365ab16279bb33312583c320008e391f26e

inherit flag-o-matic toolchain-funcs autotools

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="https://gnupg.org/aegypten2/index.html"
SRC_URI="https://github.com/gpg/pinentry/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps static"

CDEPEND="
	>=lib-dev/libassuan-2.1
	>=lib-dev/libgcrypt-1.6.3
	>=lib-dev/libgpg-error-1.17
	caps? ( lib-sys/libcap )
	static? ( >=lib-sys/ncurses-5.7-r5:0=[static-libs] )
"
DEPEND="${CDEPEND}
	sys-devel/gettext
	dev-util/pkgconf
"

append-cxxflags -std=gnu++11

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--enable-pinentry-tty
		--disable-ncurses
		--disable-pinentry-curses
		--disable-pinentry-emacs
		--disable-fallback-curses
		--disable-pinentry-gtk2
		--disable-pinentry-qt5
		--without-ncurses-include-dir
		$(use_with caps libcap)
		--disable-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
