# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"

inherit xdg cmake user flag-o-matic

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
SNAPSHOT=42ec9594d069cf3f3213d0b58b6352cfa4313d55
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
	use createuser && enewuser qbittorrent -1 /usr/bin/nologin "/var/lib/qbittorrent" qbittorrent
}

src_prepare() {
	grep -qE '^set\(minOpenSSLVersion[[:space:]]+3\.0\.2\)$' CMakeLists.txt \
		|| die "qBittorrent OpenSSL minimum changed"

	sed -i -E \
		's/^set\(minOpenSSLVersion[[:space:]]+3\.0\.2\)$/set(minOpenSSLVersion 1.1.1)/' \
		CMakeLists.txt || die

	grep -qE '^set\(minOpenSSLVersion[[:space:]]+1\.1\.1\)$' CMakeLists.txt \
		|| die "failed to lower qBittorrent OpenSSL minimum"

	cmake_src_prepare
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
