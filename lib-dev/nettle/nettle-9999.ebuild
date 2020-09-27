# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="Low-level cryptographic library"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/gnutls/nettle.git"
	inherit git-r3
else
	SNAPSHOT=04117efd723675a4302d75c8bc1eb8cdad48c63b
	SRC_URI="https://github.com/gnutls/nettle/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="|| ( LGPL-3 LGPL-2.1 )"
SLOT="0"

IUSE="+gmp static-libs test"

DEPEND="gmp? ( >=lib-dev/gmp-5.0:0= )"

src_prepare() {
	default

	sed -e '/CFLAGS=/s: -ggdb3::' \
		-i configure.ac || die

	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable gmp public-key)
		$(use_enable static-libs static)
		$(tc-is-static-only && echo --disable-shared)
		--disable-documentation
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
