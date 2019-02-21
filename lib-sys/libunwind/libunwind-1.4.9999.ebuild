# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 flag-o-matic

DESCRIPTION="Portable and efficient API to determine the call-chain of a program"
HOMEPAGE="https://savannah.nongnu.org/projects/libunwind"
EGIT_REPO_URI="https://github.com/libunwind/libunwind.git"
EGIT_BRANCH="v1.4-stable"

LICENSE="MIT"
SLOT="7"
KEYWORDS="amd64 arm64"
IUSE="debug debug-frame doc libatomic lzma +static-libs"

RDEPEND="lzma? ( app-compression/xz-utils )"
DEPEND="${RDEPEND}
	libatomic? ( lib-dev/libatomic_ops )"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	eautoreconf
	default
	# Since we have tests disabled via RESTRICT, disable building in the subdir
	# entirely.  This worksaround some build errors too. #484846
	sed -i -e '/^SUBDIRS/s:tests::' Makefile.in || die
}

src_configure() {
	ECONF_SOURCE="${S}" \
	ac_cv_header_atomic_ops_h=$(usex libatomic) \
	econf \
		--enable-cxx-exceptions \
		--enable-coredump \
		--enable-ptrace \
		--enable-setjmp \
		$(use_enable debug-frame) \
		$(use_enable doc documentation) \
		$(use_enable lzma minidebuginfo) \
		$(use_enable static-libs static) \
		$(use_enable debug conservative_checks) \
		$(use_enable debug)
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
	# libunwind-ptrace.a (and libunwind-ptrace.h) is separate API and without
	# shared library, so we keep it in any case
	use static-libs || find "${ED}"usr '(' -name 'libunwind-generic.a' -o -name 'libunwind*.la' ')' -delete
}
