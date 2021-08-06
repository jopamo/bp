# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 flag-o-matic user

DESCRIPTION="The secure, private, untraceable cryptocurrency"
HOMEPAGE="https://www.getmonero.org https://github.com/monero-project/monero"
SRC_URI=""
EGIT_REPO_URI="https://github.com/monero-project/monero.git"
EGIT_COMMIT="v${PV}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+daemon hw-wallet readline tools +wallet-cli +wallet-rpc"

REQUIRED_USE="|| ( daemon tools wallet-cli wallet-rpc )"

DEPEND="
	lib-dev/boost
	lib-dev/libsodium
	app-server/unbound
	lib-net/czmq
	virtual/ssl
	readline? ( lib-sys/readline )"

PATCHES=("${FILESDIR}/${PN}-0.17.1.3-linkjobs.patch")

filter-flags -flto\=\*
filter-flags -Wl,-z,defs

pkg_setup() {
	enewgroup monero
	enewuser monero -1 -1 /var/lib/monero monero
}

src_configure() {
	local mycmakeargs=(
		# Monero's liblmdb conflicts with the system liblmdb :(
		-DBUILD_SHARED_LIBS=OFF
		-DMANUAL_SUBMODULES=ON
		-DMONERO_PARALLEL_LINK_JOBS=1
	)

	cmake_src_configure
}

src_compile() {
	local targets=()
	use daemon && targets+=(daemon)
	use tools && targets+=(blockchain_{ancestry,blackball,db,depth,export,import,prune,prune_known_spent_data,stats,usage})
	use wallet-cli && targets+=(simplewallet)
	use wallet-rpc && targets+=(wallet_rpc_server)
	cmake_build ${targets[@]}
}

src_install() {
	# Install all binaries.
	find "${BUILD_DIR}/bin/" -type f -executable -print0 |
		while IFS= read -r -d '' line; do
			dobin "$line"
		done

	if use daemon; then
		dodoc utils/conf/monerod.conf

		# data-dir
		keepdir /var/lib/monero
		fowners monero:monero /var/lib/monero
		fperms 0755 /var/lib/monero

		# log-file dir
		keepdir /var/log/monero
		fowners monero:monero /var/log/monero
		fperms 0755 /var/log/monero
	fi
}
