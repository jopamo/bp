# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"
SRC_URI="https://download.open-mpi.org/release/hwloc/v$(ver_cut 1-2)/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cairo debug +numa +pci plugins svg static-libs xml X"

DEPEND="
	virtual/curses
	cairo? ( xgui-lib/cairo )
	pci? (
		app-core/pciutils
		xgui-lib/libpciaccess
	)
	numa? ( app-util/numactl )
	xml? ( lib-core/libxml2 )
"

BDEPEND="app-dev/pkgconf"



src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable cairo)
		$(use_enable debug)
		$(use_enable pci)
		$(use_enable plugins)
		$(use_enable xml libxml2)
		$(use_with X x)
		--disable-cuda
		--disable-gl
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
