# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal toolchain-funcs eutils

DESCRIPTION="Transport Independent RPC library (SunRPC replacement)"
HOMEPAGE="http://libtirpc.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/libtirpc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/3" # subslot matches SONAME major
KEYWORDS="amd64 arm64"
IUSE="ipv6 static-libs"

DEPEND="app-compression/xz-utils
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]"

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable ipv6)
		--disable-gssapi
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf ${myconf[@]}
}

multilib_src_install() {
	default
}

multilib_src_install_all() {
	insinto /etc
	doins doc/netconfig

	insinto /usr/include/tirpc
	doins -r "${S}"/tirpc/*

	# makes sure that the linking order for nfs-utils is proper, as
	# libtool would inject a libgssglue dependency in the list.
	if ! use static-libs ; then
		find "${ED}" -name "*.la" -delete || die
	fi
}
