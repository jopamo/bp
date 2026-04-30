# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="RC_$(ver_cut 1)_$(ver_cut 2)"

inherit cmake flag-o-matic

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://libtorrent.org"
SNAPSHOT=c4552f38c575275f50933f4c91ed7f745306d870
ASIO_GNUTLS_SNAPSHOT=a57d4d36923c5fafa9698e14be16b8bc2913700a
TRY_SIGNAL_SNAPSHOT=105cce59972f925a33aa6b1c3109e4cd3caf583d
LIBSIMULATOR_SNAPSHOT=94dc46cccb6fec42072cb193b8a92a1dc84efca0
SRC_URI="
	https://github.com/arvidn/libtorrent/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/paullouisageneau/boost-asio-gnutls/archive/${ASIO_GNUTLS_SNAPSHOT}.tar.gz -> ${PN}-asio-gnutls-${ASIO_GNUTLS_SNAPSHOT}.tar.gz
	https://github.com/arvidn/try_signal/archive/${TRY_SIGNAL_SNAPSHOT}.tar.gz -> ${PN}-try_signal-${TRY_SIGNAL_SNAPSHOT}.tar.gz
	https://github.com/arvidn/libsimulator/archive/${LIBSIMULATOR_SNAPSHOT}.tar.gz -> ${PN}-libsimulator-${LIBSIMULATOR_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-dev/boost
	virtual/ssl
"
DEPEND="${RDEPEND}
	app-crypto/botan
	app-build/libtool
"

append-cxxflags -lboost_system

src_prepare() {
	rm -rf "${S}/deps/asio-gnutls" || die
	mv "${WORKDIR}/boost-asio-gnutls-${ASIO_GNUTLS_SNAPSHOT}" "${S}/deps/asio-gnutls" || die

	rm -rf "${S}/deps/try_signal" || die
	mv "${WORKDIR}/try_signal-${TRY_SIGNAL_SNAPSHOT}" "${S}/deps/try_signal" || die

	rm -rf "${S}/simulation/libsimulator" || die
	mv "${WORKDIR}/libsimulator-${LIBSIMULATOR_SNAPSHOT}" "${S}/simulation/libsimulator" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-Dstatic_runtime=OFF
		-Dencryption=ON
		-Ddht=ON
		-Ddeprecated-functions=OFF
		-Dexceptions=ON
		-Dlogging=OFF
		-Dbuild_tests=OFF
		)

	cmake_src_configure
}
