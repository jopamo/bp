# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson qa-policy

DESCRIPTION="Native multicall multitool"
HOMEPAGE="https://github.com/jopamo/bx"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/jopamo/bx"
	inherit git-r3
else
	SNAPSHOT=0cc18f6e46e184bdeee6a049ecc5ddd8caeb3801
	SRC_URI="https://github.com/jopamo/bx/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2+ GPL-3+ LGPL-2.1+ BSD BSD-2 ISC Info-ZIP MIT vim"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+static"

RDEPEND="
	!app-compression/zip-utils
	!app-net/mira
	static? (
		app-compression/bzip2[static-libs(+)]
		app-compression/xz-utils[static-libs(+)]
		app-compression/zstd[static-libs(+)]
		app-net/curl[static-libs(+)]
		lib-core/libpcre2[static-libs(+)]
		lib-core/zlib[static-libs(+)]
		lib-misc/lexbor[static-libs(+)]
		virtual/curses[static-libs]
	)
	!static? (
		app-compression/bzip2
		app-compression/xz-utils
		app-compression/zstd
		app-net/curl[shared]
		lib-core/libpcre2
		lib-core/zlib
		lib-misc/lexbor
		virtual/curses
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-dev/pkgconf
	app-lang/python:3
"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Dstatic_binary=$(usex static enabled disabled)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
