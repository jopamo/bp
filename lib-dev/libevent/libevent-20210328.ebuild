# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://libevent.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/libevent/libevent.git"
	inherit git-r3 autotools
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=28f0fe6fd1e2b1e9fb24a5c7a5b078790890e44f
	SRC_URI="https://github.com/libevent/libevent/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
	inherit autotools
else
	SRC_URI="https://github.com/libevent/libevent/releases/download/release-${PV}-stable/${P}-stable.tar.gz"
	S=${WORKDIR}/${P}-stable
fi

LICENSE="BSD"
SLOT="0"

IUSE="debug mbedtls +ssl static-libs test"

RESTRICT="test"

DEPEND="
	ssl? ( virtual/ssl )
	mbedtls? ( lib-net/mbedtls )
"

filter-flags -Wl,-z,defs

src_prepare() {
	if [[ ${PV} == *9999 ]] || [[ ${PV} == 20* ]] ; then
		eautoreconf
	fi

	default
}

src_configure() {
	# fix out-of-source builds
	mkdir -p test || die

	local myconf=(
		--disable-samples
		$(use_enable mbedtls)
		$(use_enable debug debug-mode)
		$(use_enable debug malloc-replacement)
		$(use_enable ssl openssl)
		$(use_enable static-libs static)
		$(use_enable test libevent-regress)
		--enable-thread-support
	)

	ECONF_SOURCE="${S}" econf ${myconf[@]}
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
