# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Portable and efficient API to determine the call-chain of a program"
HOMEPAGE="https://savannah.nongnu.org/projects/libunwind"
SNAPSHOT=9343c6d3232b131c0295886a5949a673ee0a8c5f
SRC_URI="https://github.com/libunwind/libunwind/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libunwind-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug debug-frame static-libs"

src_prepare() {
	filter-flags -Wl,-z,defs

	default
	eautoreconf

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
