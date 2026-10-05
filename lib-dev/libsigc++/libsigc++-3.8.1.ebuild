# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic meson

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="https://libsigcplusplus.github.io/libsigcplusplus/"

SRC_URI="https://github.com/libsigcplusplus/libsigcplusplus/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="test"

src_configure() {
	filter-flags -fno-exceptions #84263

	local -a emesonargs=(
		$(meson_use test benchmark)
		-Dbuild-documentation=false
		-Dbuild-examples=false
		$(meson_use test build-tests)
		-Dmaintainer-mode=false
	)
	meson_src_configure
}
