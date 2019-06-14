# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Simple passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="https://gnupg.org/aegypten2/index.html"
SRC_URI="https://www.gnupg.org/ftp/gcrypt/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="caps static"

CDEPEND="
	>=lib-dev/libassuan-2.1
	>=lib-dev/libgcrypt-1.6.3
	>=lib-dev/libgpg-error-1.17
	caps? ( lib-sys/libcap-ng )
	static? ( >=lib-sys/ncurses-5.7-r5:0=[static-libs,-gpm] )
"
DEPEND="${CDEPEND}
	sys-devel/gettext
	dev-util/pkgconf
"

src_configure() {
	use static && append-ldflags -static
	[[ "$(gcc-major-version)" -ge 5 ]] && append-cxxflags -std=gnu++11

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-pinentry-tty
		--disable-ncurses
		--disable-pinentry-curses
		--disable-pinentry-emacs
		--disable-fallback-curses
		--disable-pinentry-gtk2
		--without-ncurses-include-dir
		$(use_with caps libcap)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
