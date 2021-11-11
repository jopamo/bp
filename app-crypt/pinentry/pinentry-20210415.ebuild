# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=7f7fd8bcfd74919091cc318b27b8617a9ef2ac82

inherit flag-o-matic toolchain-funcs autotools

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="https://gnupg.org/aegypten2/index.html"
SRC_URI="https://github.com/gpg/pinentry/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps static"

DEPEND="
	>=lib-core/libassuan-2.1
	>=lib-core/libgcrypt-1.6.3
	>=lib-core/libgpg-error-1.17
	caps? ( lib-core/libcap )
"
BDEPEND="app-build/gettext
	dev-util/pkgconf"

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
