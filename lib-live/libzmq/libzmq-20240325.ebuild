# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"

SNAPSHOT=2a75ef07be0ba76f86592e10b999331cd6124d52
SRC_URI="https://github.com/zeromq/libzmq/archive/${SNAPSHOT}.tar.gz -> libzmq-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libzmq-${SNAPSHOT}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libunwind +sodium static-libs test"

DEPEND="
	app-core/util-linux
	libunwind? ( lib-live/libunwind )
	sodium? ( lib-live/libsodium )
"
PDEPEND="
	lib-live/cppzmq
	lib-live/czmq
	lib-live/zmqpp
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
