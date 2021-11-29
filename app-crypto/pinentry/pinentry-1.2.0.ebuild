# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="https://gnupg.org/aegypten2/index.html"
SRC_URI="https://gnupg.org/ftp/gcrypt/pinentry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps static"

DEPEND="
	lib-core/libassuan
	lib-core/libgcrypt
	lib-core/libgpg-error
	caps? ( lib-core/libcap )
"
BDEPEND="
	app-build/gettext
	app-dev/pkgconf
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
