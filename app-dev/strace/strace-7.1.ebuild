# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="https://strace.io/"
SRC_URI="https://github.com/strace/strace/releases/download/v${PV}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libunwind static"

DEPEND="libunwind? ( lib-dev/libunwind )"

append-flags -Wno-stringop-overflow -Wno-maybe-uninitialized

src_prepare() {
	default

	# Stub out the -k test since it's known to be flaky. bug #545812
	sed -i '1iexit 77' tests*/strace-k.test || die
}

src_configure() {
	local myconf=(
		$(use_with libunwind)
		--enable-mpers=check
		--disable-gcc-Werror
		--enable-bundled=yes
	)
	econf "${myconf[@]}"
}
