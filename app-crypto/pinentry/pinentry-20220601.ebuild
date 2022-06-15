# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="523a4f2d5d1c37df5ea7922f9545823afb3cb762"
SHORT=${SNAPSHOT:0:7}

inherit autotools

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="https://gnupg.org/aegypten2/index.html"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=${PN}.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SHORT}

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
		--enable-pinentry-tty
		--without-ncurses-include-dir
		$(use_with caps libcap)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
