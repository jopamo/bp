# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="Library providing generic access to the PCI bus and devices"
IUSE="zlib"
SLOT=0

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/libpciaccess"
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://www.x.org/archive/individual/lib/${P}.tar.bz2"
fi

DEPEND="!<x11-app/xorg-server-1.5
	zlib? (	>=lib-sys/zlib-1.2.8-r1:=[${MULTILIB_USEDEP}] )"
RDEPEND="${DEPEND}
	sys-app/systemd"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_with zlib)
		--with-pciids-path=${EPREFIX}/usr/share/misc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	default

	if multilib_is_native_abi; then
		dodir /usr/bin
		${BASH} libtool --mode=install "$(type -P install)" -c scanpci/scanpci "${ED}"/usr/bin || die
	fi
}
