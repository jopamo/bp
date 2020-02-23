# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="userspace RCU (read-copy-update) library"
HOMEPAGE="https://liburcu.org/"
SRC_URI="https://lttng.org/files/urcu/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs regression-test"

src_configure() {
	local myconf=(
		--enable-shared
		$(use_enable static-libs static)
	)
	econf "${myconf[@]}"
}

src_test() {
	default
	if use regression-test; then
		emake -C tests/regression regtest
	fi
}
