# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 flag-o-matic

DESCRIPTION="Portable and efficient API to determine the call-chain of a program"
HOMEPAGE="https://savannah.nongnu.org/projects/libunwind"
EGIT_REPO_URI="https://github.com/libunwind/libunwind.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug debug-frame libatomic static-libs"

DEPEND="libatomic? ( lib-dev/libatomic_ops )"

filter-flags -Wl,-z,defs

src_prepare() {
	eautoreconf
	default
	# Since we have tests disabled via RESTRICT, disable building in the subdir
	# entirely.  This worksaround some build errors too. #484846
	sed -i -e '/^SUBDIRS/s:tests::' Makefile.in || die
}

src_configure() {
	local myconf=(
		--enable-cxx-exceptions
		--enable-coredump
		--enable-ptrace
		--enable-setjmp
		--disable-minidebuginfo
		--disable-documentation
		$(use_enable debug-frame)
		$(use_enable static-libs static)
		$(use_enable debug conservative_checks)
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	CCACHE_NODIRECT=1 default
}

src_test() {
	# Explicitly allow parallel build of tests.
	# Sandbox causes some tests to freak out.
	SANDBOX_ON=0 emake check
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -delete
}
