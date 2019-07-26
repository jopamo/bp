# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="A brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"
EGIT_REPO_URI="https://github.com/zeromq/${PN}.git"

LICENSE="LGPL-3"
SLOT="0/5"
KEYWORDS="amd64 arm64"

IUSE="pgm +sodium static-libs test unwind"

RDEPEND="
	unwind? ( lib-sys/libunwind )
	sodium? ( lib-dev/libsodium:= )
	pgm? ( =lib-net/openpgm-5.2.122 )"

DEPEND="${RDEPEND}
	sys-app/util-linux
	pgm? ( dev-util/pkgconf )"

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

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
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

src_test() {
	emake -j1 check
}
