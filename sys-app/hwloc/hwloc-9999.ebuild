# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools cuda flag-o-matic versionator multilib-minimal

DESCRIPTION="displays the hardware topology in convenient formats"
HOMEPAGE="http://www.open-mpi.org/projects/hwloc/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/open-mpi/${PN}.git"

else
	SRC_URI="https://github.com/open-mpi/${PN}/archive/${PN}-${PV}.tar.gz"
	S="${WORKDIR}/${PN}-${PN}-${PV}"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="cairo cuda debug gl +numa +pci plugins svg static-libs xml X"

# opencl support dropped with x11/ati-drivers being removed (#582406).
# Anyone with hardware is welcome to step up and help test to get it re-added.

# nvidia/nvidia-cuda-toolkit is always multilib

RDEPEND="
	>=lib-sys/ncurses-5.9-r3:0[${MULTILIB_USEDEP}]
	cairo? ( >=x11-libs/cairo-1.12.14-r4[X?,svg?,${MULTILIB_USEDEP}] )
	cuda? ( >=nvidia/nvidia-cuda-toolkit-6.5.19-r1 )
	gl? ( nvidia/nvidia-drivers[static-libs,tools]  )
	pci? (
		>=sys-app/pciutils-3.3.0-r2[${MULTILIB_USEDEP}]
		>=x11-libs/libpciaccess-0.13.1-r1[${MULTILIB_USEDEP}]
	)
	plugins? ( lib-dev/libltdl:0[${MULTILIB_USEDEP}] )
	numa? ( >=sys-app/numactl-2.0.11-r1[${MULTILIB_USEDEP}] )
	xml? ( >=lib-dev/libxml2-2.9.1-r4[${MULTILIB_USEDEP}] )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}-gl.patch" )
DOCS=( AUTHORS NEWS README VERSION )

src_prepare() {
	default
	eautoreconf

	if use cuda ; then
		append-cflags -I"${EPREFIX}"/opt/cuda/include
		append-cppflags -I"${EPREFIX}"/opt/cuda/include
	fi
}
multilib_src_configure() {
	export HWLOC_PKG_CONFIG=$(tc-getPKG_CONFIG) #393467

	if use cuda ; then
		append-ldflags -L"${EPREFIX}"/opt/cuda/$(get_libdir)
	fi

	ECONF_SOURCE=${S} econf \
		$(use_enable static-libs static) \
		$(use_enable cairo) \
		$(multilib_native_use_enable cuda) \
		$(use_enable debug) \
		$(multilib_native_use_enable gl) \
		$(use_enable pci) \
		$(use_enable plugins) \
		$(use_enable xml libxml2) \
		$(use_with X x)
}
