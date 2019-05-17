# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Library providing generic access to the PCI bus and devices"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/libpciaccess"
else
	SRC_URI="https://www.x.org/archive/individual/lib/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="zlib"

DEPEND="!<x11-app/xorg-server-1.5
	zlib? (	>=lib-sys/zlib-1.2.8-r1:= )"
RDEPEND="${DEPEND}
	sys-app/systemd"

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
		$(use_with zlib)
		--with-pciids-path=${EPREFIX}/usr/share/misc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
