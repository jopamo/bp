# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="awesomeWM"
HOMEPAGE="https://github.com/awesomeWM/awesome.git"
EGIT_REPO_URI="https://github.com/awesomeWM/awesome.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	# Compression of manpages is handled by portage
	local mycmakeargs=(
		-DSYSCONFDIR="${EPREFIX}"/etc
		-DCOMPRESS_MANPAGES=OFF
		-DGENERATE_DOC=OFF
		-DAWESOME_DOC_PATH="${EPREFIX}"/usr/share/doc/${PF}
	)
	cmake_src_configure
}
