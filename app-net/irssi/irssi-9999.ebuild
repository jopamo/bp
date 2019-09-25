# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 flag-o-matic

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="https://irssi.org/"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

BDEPEND="dev-lang/perl"

DEPEND="
	lib-sys/ncurses
	lib-dev/glib
	lib-net/libressl
"

filter-flags -Wl,-z,defs -Wl,-z,relro -flto\=\*

src_prepare() {
	perl utils/syntax.pl || die

	files=`echo docs/help/in/*.in| \
	sed -e 's,docs/help/in/Makefile.in ,,' -e 's,docs/help/in/,!,g' -e 's/\.in /.in ?/g'`
	cat docs/help/in/Makefile.am.gen|sed "s/@HELPFILES@/$files/g"| \
	sed 's/?/\\?/g'|tr '!?' '\t\n' > docs/help/in/Makefile.am

	files=`echo $files|sed 's/\.in//g'`
	cat docs/help/Makefile.am.gen|sed "s/@HELPFILES@/$files/g"|	\
	sed 's/?/\\?/g'|tr '!?' '\t\n' > docs/help/Makefile.am

	eapply_user
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-true-color
		--without-proxy
		--without-perl
		--without-socks
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install
	cleanup_install
}
