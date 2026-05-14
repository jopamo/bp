# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson qa-policy

DESCRIPTION="Modern recursive network retriever"
HOMEPAGE="https://github.com/jopamo/mira"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/pjo/mira"
	inherit git-r3
else
	SNAPSHOT=8046be5c26d9c24c9cee044c10bc4a84c61d3f8f
	SRC_URI="https://gitlab.com/pjo/mira/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug http2 ipv6 +static test zstd"

RDEPEND="
	static? (
		app-net/curl[-shared,static-libs]
		lib-core/zlib[static-libs(+)]
		lib-net/c-ares[static-libs(+)]
	)
	!static? (
		app-net/curl[shared]
		lib-core/zlib
		lib-net/c-ares
	)
	ipv6? ( app-net/curl[ipv6] )
	http2? (
		app-net/curl[nghttp2]
		static? ( lib-net/nghttp2[static-libs(+)] )
		!static? ( lib-net/nghttp2 )
	)
	zstd? (
		static? ( app-compression/zstd[static-libs(+)] )
		!static? ( app-compression/zstd )
	)
"

DEPEND="
	${RDEPEND}
	test? ( app-lang/python:3 )
"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		$(meson_use debug debug)
		$(meson_use http2 http2)
		$(meson_use ipv6 ipv6)
		$(meson_use test tests)
		$(meson_use zstd zstd)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
