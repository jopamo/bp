# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit libtool toolchain-funcs flag-o-matic

DESCRIPTION="access control list utilities, libraries and headers"
HOMEPAGE="https://savannah.nongnu.org/projects/acl"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static-libs"

DEPEND=">=sys-app/attr-2.4.47-r1"

replace-flags -O3 -O2

src_prepare() {
	default
	strip-linguas po
	elibtoolize
}

src_configure() {
	unset PLATFORM
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-shared $(use_enable static-libs static)
		$(use_enable nls)
	)
	econf "${myeconfargs[@]}"
}
