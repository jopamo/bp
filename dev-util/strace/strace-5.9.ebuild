# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="https://sourceforge.net/projects/strace/"
SRC_URI="https://github.com/strace/strace/releases/download/v${PV}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="aio static"

DEPEND="aio? ( >=lib-dev/libaio-0.3.106 )
		lib-sys/libunwind"

append-flags -Wno-stringop-overflow

src_prepare() {
	default

	use static && append-ldflags -static

	export ac_cv_header_libaio_h=$(usex aio)

	# Stub out the -k test since it's known to be flaky. #545812
	sed -i '1iexit 77' tests*/strace-k.test || die
}

src_configure() {
	local myconf=(
		--with-libunwind
		--enable-mpers=check
	)
	econf ${myconf[@]}
}
