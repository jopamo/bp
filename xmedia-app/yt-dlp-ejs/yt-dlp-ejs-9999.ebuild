# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DISTUTILS_USE_PEP517=hatchling

DESCRIPTION="External JavaScript for yt-dlp supporting many runtimes"
HOMEPAGE="https://github.com/yt-dlp/ejs"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/yt-dlp/ejs"
	inherit git-r3
else
	SNAPSHOT=168e72dcd3e04e0e19e92c012a04b8a1e4658f50
	SRC_URI="https://github.com/yt-dlp/ejs/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/yt-dlp-${SNAPSHOT}
fi

LICENSE="unlicense"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-rust/deno"

RESTRICT="test network-sandbox"
