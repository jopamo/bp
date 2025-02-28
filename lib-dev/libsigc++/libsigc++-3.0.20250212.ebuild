# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit flag-o-matic meson

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="https://libsigcplusplus.github.io/libsigcplusplus/"

SNAPSHOT=4e68e1753b42be120d5a64a9b7cc0fc110f86428
SRC_URI="https://github.com/libsigcplusplus/libsigcplusplus/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libsigcplusplus-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="3"
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
