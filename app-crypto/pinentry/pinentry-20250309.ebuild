# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=72b827b33e95df0dd1c14f193778e236e0bcbae6

inherit autotools

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
