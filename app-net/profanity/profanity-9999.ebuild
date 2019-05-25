# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools flag-o-matic

DESCRIPTION="A console based XMPP client inspired by Irssi"
HOMEPAGE="http://www.profanity.im/"
EGIT_REPO_URI="https://github.com/profanity-im/profanity.git"

LICENSE="GPL-3"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+otr python-plugins c-plugins +omemo"

filter-flags -Werror -flto

DEPEND="
	lib-net/libmesode
	otr? ( lib-net/libotr )
	omemo? ( lib-net/libsignal-protocol-c )
"

src_prepare() {
	default
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
		$(use_enable otr)
		$(use_enable python-plugins)
		$(use_enable c-plugins)
		$(use_enable omemo)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
