# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit browser-user-agent meson qa-policy

DESCRIPTION="Multicall command-line utilities"
HOMEPAGE="https://github.com/jopamo/bx"

EGIT_REPO_URI="https://github.com/jopamo/bx"
inherit git-r3

LICENSE="Apache-2.0 ZLIB GPL-2+ GPL-3+ LGPL-2.1+ BSD BSD-2 ISC Info-ZIP MIT vim"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+static"

RDEPEND="
	!app-compression/pigz
	!app-var/crunch
	!app-var/symlinks
	!app-net/knock
	!app-compression/zip-utils
	!app-fs/dosfstools
	!app-net/mira
	!app-net/rsync
	!dev-rust/ripgrep
	static? (
		app-compression/bzip2[static-libs(+)]
		app-compression/xz-utils[static-libs(+)]
		app-compression/zstd[static-libs(+)]
		app-net/curl[static-libs(+)]
		lib-core/libpcre2[static-libs(+)]
		lib-core/zlib[static-libs(+)]
		lib-misc/liblexa[static-libs(+)]
		virtual/curses[static-libs]
	)
	!static? (
		app-compression/bzip2
		app-compression/xz-utils
		app-compression/zstd
		app-net/curl[shared]
		lib-core/libpcre2
		lib-core/zlib
		lib-misc/liblexa
		virtual/curses
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-dev/pkgconf
	app-lang/python
"

src_configure() {
	qa-policy-configure
	bp_browser_versions

	local emesonargs=(
		-Dstatic_binary=$(usex static enabled disabled)
		-Dmira_chrome_version="${BP_CHROME_VERSION}"
		-Dmira_firefox_version="${BP_FIREFOX_VERSION}"
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
