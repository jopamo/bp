# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils libtool ltprune toolchain-funcs multilib-minimal

DESCRIPTION="access control list utilities, libraries and headers"
HOMEPAGE="https://savannah.nongnu.org/projects/acl"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="nls static-libs"

DEPEND=">=sys-app/attr-2.4.47-r1[${MULTILIB_USEDEP}]"

src_prepare() {
	default
	strip-linguas po
	elibtoolize
	multilib_copy_sources
}

multilib_src_configure() {
	unset PLATFORM
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-shared $(use_enable static-libs static)
		$(use_enable nls)
	)
	econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	default
	use static-libs || find "${ED}" -name '*.*a' -delete
	use static-libs || prune_libtool_files --all
}
