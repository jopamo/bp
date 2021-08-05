# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"
SRC_URI="https://download.open-mpi.org/release/hwloc/v$(ver_cut 1-2)/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cairo cuda debug gl +numa +pci plugins svg static-libs xml X"

RDEPEND="
	>=lib-sys/ncurses-5.9-r3:0
	cairo? ( >=lib-gui/cairo-1.12.14-r4 )
	cuda? ( nvidia/nvidia-cuda )
	gl? ( nvidia/nvidia-drivers[static-libs]  )
	pci? (
		>=sys-app/pciutils-3.3.0-r2
		>=x11-libs/libpciaccess-0.13.1-r1
	)
	numa? ( >=sys-app/numactl-2.0.11-r1 )
	xml? ( >=lib-core/libxml2-2.9.1-r4 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconf-0-r1"

src_prepare() {
	default

	if use cuda ; then
		append-cflags -I"${EPREFIX}"/opt/cuda/include
		append-cppflags -I"${EPREFIX}"/opt/cuda/include
	fi
}

src_configure() {
	if use cuda ; then
		append-ldflags -L"${EPREFIX}"/opt/cuda/lib
	fi

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_enable cairo)
		$(use_enable cuda)
		$(use_enable debug)
		$(use_enable gl)
		$(use_enable pci)
		$(use_enable plugins)
		$(use_enable xml libxml2)
		$(use_with X x)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
