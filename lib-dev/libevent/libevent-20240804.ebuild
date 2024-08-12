# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://libevent.org/"

SNAPSHOT=d3f6c78e3ac92048058784298564407fef7d63ae
SRC_URI="https://github.com/libevent/libevent/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

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
