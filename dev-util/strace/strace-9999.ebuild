# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/strace/strace.git"
	inherit git-r3 autotools
else
	SRC_URI="https://github.com/strace/strace/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="https://sourceforge.net/projects/strace/"

LICENSE="BSD"
SLOT="0"
IUSE="aio perl static"

DEPEND="aio? ( >=lib-dev/libaio-0.3.106 )
		lib-sys/libunwind"

src_prepare() {
	default

	if [[ ! -e configure ]] ; then
		# git generation
		./xlat/gen.sh || die
		./generate_mpers_am.sh || die
		eautoreconf
		[[ ! -e CREDITS ]] && cp CREDITS{.in,}
	fi

	filter-lfs-flags # configure handles this sanely
	use static && append-ldflags -static

	export ac_cv_header_libaio_h=$(usex aio)
	use elibc_musl && export ac_cv_header_stdc=no

	# Stub out the -k test since it's known to be flaky. #545812
	sed -i '1iexit 77' tests*/strace-k.test || die
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-mpers=check
		--with-libunwind
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
