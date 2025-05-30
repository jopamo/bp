# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=c93e640fa8ca8ddb0eaee53fc65b03cf3004eb4b
SHORT=${SNAPSHOT:0:7}

inherit autotools

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="https://gnupg.org/aegypten2/index.html"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=pinentry.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SHORT}

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
		--enable-ncurses
		--disable-pinentry-curses
		--disable-pinentry-emacs
		--disable-pinentry-gtk2
		--disable-pinentry-qt5
		--enable-pinentry-tty
		--without-ncurses-include-dir
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
