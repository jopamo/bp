# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools perl-module git-r3 flag-o-matic

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="https://irssi.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+perl socks5 +proxy libressl"

DEPEND="lib-sys/ncurses:0=
	>=lib-dev/glib-2.6.0
	!libressl? ( lib-dev/openssl:= )
	libressl? ( lib-dev/libressl:= )
	perl? ( dev-lang/perl:= )"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	sed -i -e /^autoreconf/d autogen.sh || die
	NOCONFIGURE=1 ${S}/autogen.sh || die

	eapply_user
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-true-color
		$(use_with proxy)
		$(use_with perl)
		$(use_with socks5 socks)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install
}
