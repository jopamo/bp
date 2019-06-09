# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit libtool toolchain-funcs

DESCRIPTION="Extended attributes tools"
HOMEPAGE="https://savannah.nongnu.org/projects/attr"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nls static-libs debug"

PATCHES=( "${FILESDIR}/${P}-perl-5.26.patch")

src_prepare() {
	default
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
		--enable-shared
		$(use_enable static-libs static)
		$(use_enable nls)
		$(use_enable debug)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install() {
	default
	insinto /usr/include/attr
	newins "${FILESDIR}"/xattr-shim.h xattr.h
}
