# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=f1732556467bdd19fa2e432fcd64b6bf625483cb

inherit autotools flag-o-matic

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="https://gnupg.org/aegypten2/index.html"
SRC_URI="https://github.com/gpg/pinentry/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/pinentry-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="
	lib-core/libassuan
	lib-core/libgpg-error
"

src_prepare() {
	append-flags -ffat-lto-objects

	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--disable-doc
		--disable-fallback-curses
		--disable-ncurses
		--disable-pinentry-curses
		--disable-pinentry-emacs
		--disable-pinentry-gtk2
		--disable-pinentry-qt5
		--disable-pinentry-qt
		--enable-pinentry-tty
		--without-ncurses-include-dir
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
