# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="https://sourceforge.net/projects/strace/"
SRC_URI="https://github.com/strace/strace/releases/download/v${PV}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="aio perl static"

DEPEND="aio? ( >=lib-dev/libaio-0.3.106 )
		lib-sys/libunwind"

src_prepare() {
	default

	use static && append-ldflags -static

	export ac_cv_header_libaio_h=$(usex aio)

	# Stub out the -k test since it's known to be flaky. #545812
	sed -i '1iexit 77' tests*/strace-k.test || die
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-libunwind
		--enable-mpers=check
	)
	econf ${myconf[@]}
}

src_test() {
	if has usersandbox $FEATURES ; then
		ewarn "Test suite is known to fail with FEATURES=usersandbox -- skipping ..." #643044
		return 0
	fi

	default
}
