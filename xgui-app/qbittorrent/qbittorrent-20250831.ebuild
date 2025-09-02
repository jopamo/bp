# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

inherit xdg cmake user flag-o-matic

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
SNAPSHOT=becfd19e348028bd572056b755f5232976e30146
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
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"
	filter-flags -flto*
	filter-flags -Wl,-z,defs

	local mycmakeargs=(
		-DSTACKTRACE=$(usex !elibc_musl)
		-DWEBUI=$(usex webui)
		-DSYSTEMD=$(usex systemd)
		-DGUI=$(usex gui)
		-DDBUS=$(usex dbus)
		-DOPENSSL_ROOT_DIR=/usr
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
