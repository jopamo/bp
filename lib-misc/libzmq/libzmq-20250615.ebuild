# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"
SNAPSHOT=798a689df1a7945f556d5404311c6ccebb282788
SRC_URI="https://github.com/zeromq/libzmq/archive/${SNAPSHOT}.tar.gz -> libzmq-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libzmq-${SNAPSHOT}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libunwind +sodium static-libs test"

DEPEND="
	app-core/util-linux
	libunwind? ( lib-util/libunwind )
	sodium? ( lib-util/libsodium )
"
PDEPEND="
	lib-misc/cppzmq
	lib-misc/czmq
	lib-misc/zmqpp
"

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
		$(use_enable libunwind)
		$(use_with sodium libsodium)
		--without-docs
		--without-documentation
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake -j1 check
}
