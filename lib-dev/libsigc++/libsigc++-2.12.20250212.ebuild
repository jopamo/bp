# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit flag-o-matic meson

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="https://libsigcplusplus.github.io/libsigcplusplus/"

SNAPSHOT=8787f42216a3625f995dd99be3ce1d4251e60178
SRC_URI="https://github.com/libsigcplusplus/libsigcplusplus/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libsigcplusplus-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	filter-flags -fno-exceptions #84263

	local -a emesonargs=(
		$(meson_use test benchmark)
		-Dbuild-documentation=false
		-Dbuild-examples=false
		$(meson_use test build-tests)
	)
	meson_src_configure
}
