# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="A brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"
EGIT_REPO_URI="https://github.com/zeromq/${PN}.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+sodium static-libs test unwind"

RDEPEND="
	unwind? ( lib-core/libunwind )
	sodium? ( lib-dev/libsodium:= )"

DEPEND="${RDEPEND}
	app-core/util-linux"

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
		--enable-shared
		$(use_enable static-libs static)
		$(use_enable unwind libunwind)
		$(use_with sodium libsodium)
		--without-docs
		--without-documentation
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake -j1 check
}
