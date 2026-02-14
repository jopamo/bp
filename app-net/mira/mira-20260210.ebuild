# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Modern recursive network retriever"
HOMEPAGE="https://github.com/jopamo/mira"

SNAPSHOT=6be3ec94084afa009c4f46391c68b84bd4432d93
SRC_URI="https://github.com/jopamo/mira/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ipv6 static test http2 zlib zstd"

LIB_DEPEND="
	zlib? ( lib-core/zlib[static-libs(+)] )
	zstd? ( app-compression/zstd[static-libs(+)] )
	http2? ( lib-dev/nghttp2[static-libs(+)] )
"

DEPEND="
	app-net/curl
	lib-net/c-ares
	virtual/ssl

	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	static? ( ${LIB_DEPEND} )

	test? ( app-lang/python:3 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use debug debug)
		$(meson_use ipv6 ipv6)
		$(meson_use test tests)
		$(meson_use http2 http2)
		$(meson_use zstd zstd)
	)

	meson_src_configure
}
