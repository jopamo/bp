# Distributed under the terms of the GNU General Public License v2

inherit cmake doins python-any-r1

DESCRIPTION="Userspace libraries and tools for RDMA, InfiniBand, and RoCE"
HOMEPAGE="https://github.com/linux-rdma/rdma-core"
SNAPSHOT=e56695b638e18d2d6533652e34146d833d9fff7c
SRC_URI="https://github.com/linux-rdma/rdma-core/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( GPL-2 ( CC0-1.0 MIT BSD BSD-with-attribution ) )"
SLOT="0"
KEYWORDS="amd64"

IUSE="neigh static-libs systemd valgrind"

COMMON_DEPEND="
	app-lang/perl:=
	systemd? ( app-core/systemd )
	neigh? ( lib-net/libnl:= )
	valgrind? ( app-dev/valgrind )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/rdma-core-39.0-RDMA_BuildType.patch
)

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_INSTALL_RUNDIR=/run
		-DCMAKE_INSTALL_SHAREDSTATEDIR="${EPREFIX}/var/lib"
		-DCMAKE_INSTALL_UDEV_RULESDIR="${EPREFIX}$(get_udevdir)/rules.d"
		-DCMAKE_INSTALL_SYSTEMD_SERVICEDIR="${EPREFIX}/usr/lib/systemd/system"
		-DCMAKE_DISABLE_FIND_PACKAGE_Systemd="$(usex systemd OFF ON)"
		-DCMAKE_DISABLE_FIND_PACKAGE_UDev="$(usex systemd OFF ON)"
		-DTRACING=None
		-DENABLE_VALGRIND=$(usex valgrind ON OFF)
		-DENABLE_RESOLVE_NEIGH=$(usex neigh ON OFF)
		-DENABLE_STATIC=$(usex static-libs ON OFF)
		-DNO_PYVERBS=1
		-DNO_MAN_PAGES=1
		-DPYTHON_EXECUTABLE="${EPYTHON}"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if [[ -f "${ED}/usr/share/doc/${PF}/70-persistent-ipoib.rules" ]]; then
		udev_dorules "${ED}/usr/share/doc/${PF}/70-persistent-ipoib.rules"
	fi
}

pkg_postinst() {
	use systemd && udev_reload
}

pkg_postrm() {
	use systemd && udev_reload
}
