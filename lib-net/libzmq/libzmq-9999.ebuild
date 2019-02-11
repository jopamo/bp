# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools git-r3

DESCRIPTION="A brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"
EGIT_REPO_URI="https://github.com/zeromq/${PN}.git"

LICENSE="LGPL-3"
SLOT="0/5"
KEYWORDS="amd64 arm64"
IUSE="pgm +sodium static-libs test unwind elibc_Darwin"

RDEPEND="
	unwind? ( lib-sys/libunwind )
	sodium? ( lib-dev/libsodium:= )
	pgm? ( =lib-net/openpgm-5.2.122 )"

DEPEND="${RDEPEND}
	sys-app/util-linux
	pgm? ( dev-util/pkgconfig )"

PDEPEND="lib-net/cppzmq
		lib-net/czmq
		lib-net/zmqpp"

src_prepare() {
	sed \
		-e '/libzmq_werror=/s:yes:no:g' \
		-i configure.ac || die
	default
	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-shared
		$(use_enable static-libs static)
		$(use_enable unwind libunwind)
		$(use_with sodium libsodium)
		$(use_with pgm)
		--without-docs
		--without-documentation
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_test() {
	# Restricting to one job because multiple tests are using the same port.
	# Upstream knows the problem and says it doesn't support parallel test
	# execution, see ${S}/INSTALL.
	emake -j1 check
}

multilib_src_install() {
	default
	find "${ED}"usr/lib* -name '*.la' -delete || die
}
