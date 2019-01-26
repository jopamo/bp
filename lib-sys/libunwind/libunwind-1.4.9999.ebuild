# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal git-r3 flag-o-matic

DESCRIPTION="Portable and efficient API to determine the call-chain of a program"
HOMEPAGE="https://savannah.nongnu.org/projects/libunwind"
EGIT_REPO_URI="https://github.com/libunwind/libunwind.git"
EGIT_BRANCH="v1.4-stable"

LICENSE="MIT"
SLOT="7"
KEYWORDS="amd64 arm64 x86"
IUSE="debug debug-frame doc libatomic lzma +static-libs"

RDEPEND="lzma? ( app-compression/xz-utils )"
DEPEND="${RDEPEND}
	libatomic? ( lib-dev/libatomic_ops )"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/libunwind.h

	# see libunwind.h for the full list of arch-specific headers
	/usr/include/libunwind-aarch64.h
	/usr/include/libunwind-x86.h
	/usr/include/libunwind-x86_64.h
)

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	eautoreconf
	default
	# Since we have tests disabled via RESTRICT, disable building in the subdir
	# entirely.  This worksaround some build errors too. #484846
	sed -i -e '/^SUBDIRS/s:tests::' Makefile.in || die
}

multilib_src_configure() {
	# --enable-cxx-exceptions: always enable it, headers provide the interface
	# and on some archs it is disabled by default causing a mismatch between the
	# API and the ABI, bug #418253
	# conservative-checks: validate memory addresses before use; as of 1.0.1,
	# only x86_64 supports this, yet may be useful for debugging, couple it with
	# debug useflag.
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

multilib_src_compile() {
	# Bug 586208
	CCACHE_NODIRECT=1 default
}

multilib_src_test() {
	# Explicitly allow parallel build of tests.
	# Sandbox causes some tests to freak out.
	SANDBOX_ON=0 emake check
}

multilib_src_install() {
	default
	# libunwind-ptrace.a (and libunwind-ptrace.h) is separate API and without
	# shared library, so we keep it in any case
	use static-libs || find "${ED}"usr '(' -name 'libunwind-generic.a' -o -name 'libunwind*.la' ')' -delete
}
