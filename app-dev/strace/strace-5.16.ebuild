# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="https://sourceforge.net/projects/strace/"
SRC_URI="https://github.com/strace/strace/releases/download/v${PV}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libunwind static"

DEPEND="libunwind? ( lib-live/libunwind )"

append-flags -Wno-stringop-overflow

src_prepare() {
	default

	use static && append-ldflags -static

		# Stub out the -k test since it's known to be flaky. #545812
	sed -i '1iexit 77' tests*/strace-k.test || die
}

src_configure() {
	local myconf=(
		$(use_with libunwind)
		--enable-mpers=check
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
