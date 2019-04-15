# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic

DESCRIPTION="Low-level cryptographic library"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://git.lysator.liu.se/nettle/nettle.git"
	inherit git-r3
else
	SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="|| ( LGPL-3 LGPL-2.1 )"
SLOT="0"

IUSE="+gmp static-libs test"

DEPEND="gmp? ( >=lib-dev/gmp-5.0:0= )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable gmp public-key)
		$(use_enable static-libs static)
		--enable-fat
		--disable-assembler
		$(tc-is-static-only && echo --disable-shared)
		--disable-documentation
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
