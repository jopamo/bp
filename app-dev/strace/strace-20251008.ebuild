# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="https://sourceforge.net/projects/strace/"
SNAPSHOT=dc5e7a0e08ef25db60ffeecc24d08bee75b54f59
SRC_URI="https://github.com/1g4-mirror/strace/archive/${SNAPSHOT}.tar.gz -> strace-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/strace-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libunwind static"

DEPEND="libunwind? ( lib-util/libunwind )"

append-flags -Wno-stringop-overflow -Wno-maybe-uninitialized

src_prepare() {
	default

	use static && append-ldflags -static

	# Stub out the -k test since it's known to be flaky. #545812
	sed -i '1iexit 77' tests*/strace-k.test || die

	./bootstrap
}

src_configure() {
	local myconf=(
		$(use_with libunwind)
		--enable-mpers=check
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
