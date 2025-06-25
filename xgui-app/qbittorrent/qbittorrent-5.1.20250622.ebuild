# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1)_$(ver_cut 2)_x"

inherit xdg cmake user flag-o-matic

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
SNAPSHOT=ea9f3800ce70ded6db66b2c9f0d2f0513399e969
SRC_URI="https://github.com/qbittorrent/qBittorrent/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qBittorrent-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="createuser debug dbus systemd gui webui"

DEPEND="
	lib-dev/boost
	lib-misc/libtorrent
	gui? (
		xgui-lib/qttools:6
		xgui-lib/qtsvg:6
	)
"

pkg_setup() {
	use createuser && enewuser qbittorrent /usr/sbin/nologin "/var/lib/qbittorrent" qbittorrent
}

src_configure() {
	filter-flags -flto*
	filter-flags -Wl,-z,defs

	local mycmakeargs=(
		-DSTACKTRACE=$(usex !elibc_musl)
		-DWEBUI=$(usex webui)
		-DSYSTEMD=$(usex systemd)
		-DGUI=$(usex gui)
		-DDBUS=$(usex dbus)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/qbittorrent.service"
	fi
}
