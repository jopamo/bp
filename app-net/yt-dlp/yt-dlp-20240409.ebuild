# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DISTUTILS_USE_PEP517=hatchling

DESCRIPTION="a command-line program to download videos from YouTube.com and a few more sites"
HOMEPAGE="https://ytdl-org.github.io/youtube-dl/"

SNAPSHOT=168e72dcd3e04e0e19e92c012a04b8a1e4658f50
SRC_URI="https://github.com/yt-dlp/yt-dlp/archive/${SNAPSHOT}.tar.gz -> yt-dlp-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/yt-dlp-${SNAPSHOT}"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/yt-dlp/yt-dlp"
	inherit
else
	SNAPSHOT=168e72dcd3e04e0e19e92c012a04b8a1e4658f50
	SRC_URI="https://github.com/yt-dlp/yt-dlp/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="unlicense"
SLOT="0"
KEYWORDS="amd64 arm64"

python_install_all() {
	distutils-r1_python_install_all
	dosym -r /usr/bin/yt-dlp /usr/bin/youtube-dl
}
