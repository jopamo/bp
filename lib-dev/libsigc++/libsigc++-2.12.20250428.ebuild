# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="libsigc++-$(ver_cut 1)-$(ver_cut 2)"

inherit flag-o-matic meson

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="https://libsigcplusplus.github.io/libsigcplusplus/"

SNAPSHOT=1f906156ccdd2350d5da644e9ad230b02a679e92
SRC_URI="https://github.com/libsigcplusplus/libsigcplusplus/archive/${SNAPSHOT}.tar.gz -> libsigc++-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libsigcplusplus-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="test network-sandbox"

src_prepare() {
	default
	mm-common-prepare --copy --force "${S}"
}

src_configure() {
	filter-flags -fno-exceptions #84263

	local -a emesonargs=(
		$(meson_use test benchmark)
		-Dbuild-documentation=false
		-Dbuild-examples=false
		$(meson_use test build-tests)
		-D maintainer-mode=true
	)
	meson_src_configure
}
